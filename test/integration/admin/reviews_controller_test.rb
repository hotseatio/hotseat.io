# typed: strict
# frozen_string_literal: true

require "test_helper"

class Admin::ReviewsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /admin/reviews" do
    it "lists all reviews" do
      create_current_term
      create_list(:review, 6)
      sign_in create(:user, admin: true)
      get "/admin/reviews"
      assert_response :ok
      assert_select "ul"
      assert_select "ul > li", count: 6
    end

    it "redirects if a user is not an admin" do
      create_current_term
      create_list(:review, 6)
      sign_in create(:user)
      get "/admin/reviews"
      assert_response :found
      assert_equal "You are not authorized to view that page.", flash[:error]
    end
  end

  describe "GET /admin/review/:id" do
    it "shows detail about a review" do
      create_current_term
      review = create(:review)
      sign_in create(:user, admin: true)
      get "/admin/reviews/#{review.id}"
      assert_response :ok
    end

    it "redirects if a user is not an admin" do
      create_current_term
      review = create(:review)
      sign_in create(:user)
      get "/admin/reviews/#{review.id}"
      assert_response :found
      assert_equal "You are not authorized to view that page.", flash[:error]
    end
  end
end
