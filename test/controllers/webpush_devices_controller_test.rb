# typed: strict
# frozen_string_literal: true

require "test_helper"

class WebpushDevicesControllerTest < ActionDispatch::IntegrationTest
  describe "GET /webpush_devices" do
    it "authenticates a user" do
      get "/webpush_devices"
      assert_redirected_to_login
    end

    it "returns a json list of all webpush devices registered for a user" do
      user = T.let(create(:user), User)
      create_list(:webpush_device, 10, user:)
      sign_in user

      get "/webpush_devices", as: :json
      assert_response :ok
      assert_equal 10, response.parsed_body.length
    end
  end
end
