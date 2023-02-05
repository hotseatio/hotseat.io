# typed: strict
# frozen_string_literal: true

require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  test "user fills out their phone number and beta testing status" do
    create_current_term

    user = create(:user, phone: nil, beta_tester: false)
    sign_in user
    visit "/settings"

    within "#beta_tester" do
      click_button
    end

    click_button "Update account"
    assert_text page, "Settings updated!", wait: 10

    user.reload
    assert user.beta_tester
  end
end
