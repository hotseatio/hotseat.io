# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update settings', type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  scenario 'user fills out their phone number and beta testing status' do
    create_current_term

    user = create :user, phone: nil, beta_tester: false
    sign_in user
    visit '/settings'

    within '#beta_tester' do
      click_button
    end

    click_button 'Update account'
    expect(page).to have_content 'Settings updated!', wait: 10

    user.reload
    expect(user.beta_tester).to be true
  end
end
