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

  describe "PATCH/PUT /admin/review/:id" do
    it "approves a review" do
      create_current_term
      reviewer = create(:user, notification_token_count: 0)
      review = create(:review, user: reviewer)
      T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
      T.unsafe(NotifyUserAboutRejectedReviewJob).expects(:perform_later).never

      sign_in create(:user, admin: true)
      patch "/admin/reviews/#{review.id}", params: {
        status: "approved",
      }

      review.reload
      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :approved?
      assert_equal 1, reviewer.notification_token_count
    end

    it "approves a referred review" do
      create_current_term
      admin = create(:user, admin: true, notification_token_count: 0)
      reviewer = create(:user, notification_token_count: 0, referred_by: admin)
      review = create(:review, user: reviewer)
      T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
      T.unsafe(NotifyUserAboutRejectedReviewJob).expects(:perform_later).never

      sign_in admin
      patch "/admin/reviews/#{review.id}", params: {
        status: "approved",
      }

      review.reload
      reviewer.reload
      admin.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :approved?
      assert_equal 2, reviewer.notification_token_count
      assert_equal 1, admin.notification_token_count
      assert_not_nil reviewer.referral_completed_at
    end

    it "rejects a review" do
      create_current_term
      reviewer = create(:user, notification_token_count: 0)
      review = create(:review, user: reviewer)
      T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).never
      T.unsafe(NotifyUserAboutRejectedReviewJob).expects(:perform_later).once

      sign_in create(:user, admin: true)
      patch "/admin/reviews/#{review.id}", params: {
        status: "rejected",
      }

      review.reload
      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :rejected?
      assert_equal 0, reviewer.notification_token_count
    end
  end

  describe "PATCH/PUT /admin/review/all" do
    it "approves all pending reviews" do
      create_current_term
      reviewer = create(:user, notification_token_count: 0)
      reviews = create_list(:review, 10, user: reviewer)
      T.unsafe(NotifyUserAboutApprovedReviewJob).expects(:perform_later).once
      T.unsafe(NotifyUserAboutRejectedReviewJob).expects(:perform_later).never

      sign_in create(:user, admin: true)
      patch "/admin/reviews/all", params: { status: "approved" }

      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_reviews_path)
      assert_equal 10, reviewer.notification_token_count
    end
  end
end
