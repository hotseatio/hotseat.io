# typed: strict
# frozen_string_literal: true

require "test_helper"

class ErrorsTest < ActionDispatch::IntegrationTest
  describe "GET /404" do
    it "returns a 404 error" do
      create_current_term
      get "/404"

      assert_response :not_found
      assert_select "h2", "Page Not Found"
      assert_select "p", "Whoops, we couldn't find the page you were looking for."
    end
  end

  describe "GET /422" do
    it "returns a 422 error" do
      create_current_term
      get "/422"
      assert_response :unprocessable_entity
      assert_select "h2", "Unprocessable Entity"
    end
  end

  describe "GET /internal_server_error" do
    it "returns a 500 error" do
      create_current_term
      get "/500"
      assert_response :internal_server_error
      assert_select "h2", "Internal Server Error"
    end
  end
end
