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
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 0, phone:)
      review = create(:review, user: reviewer)

      message = <<~MESSAGE
        Your Hotseat review for #{review.section.course_title} was approved. You now have #{reviewer.notification_token_count + 1} notification tokens.
      MESSAGE
      stub_text_message_send(phone:, message:)

      sign_in create(:user, admin: true)
      perform_enqueued_jobs do
        patch "/admin/reviews/#{review.id}", params: {
          button: "approved",
        }
      end

      review.reload
      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :approved?
      assert_equal 1, reviewer.notification_token_count
      assert_text_message_send(phone:, message:)
    end

    it "approves a referred review" do
      create_current_term
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      admin = create(:user, admin: true, notification_token_count: 0)
      reviewer = create(:user, notification_token_count: 0, referred_by: admin, phone:)
      review = create(:review, user: reviewer)

      message = <<~MESSAGE
        Your Hotseat review for #{review.section.course_title} was approved. You now have #{reviewer.notification_token_count + 2} notification tokens.
      MESSAGE
      stub_text_message_send(phone:, message:)

      sign_in admin
      perform_enqueued_jobs do
        patch "/admin/reviews/#{review.id}", params: {
          button: "approved",
        }
      end

      review.reload
      reviewer.reload
      admin.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :approved?
      assert_equal 2, reviewer.notification_token_count
      assert_equal 1, admin.notification_token_count
      assert_not_nil reviewer.referral_completed_at
      assert_text_message_send(phone:, message:)
    end

    it "rejects a review" do
      create_current_term
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 0, phone:)
      review = create(:review, user: reviewer)

      message = <<~MESSAGE
        Your Hotseat review for #{review.section.course_title} was not approved. No worries! You can update and resubmit your review at #{edit_review_url(review)} or reach out to reviews@hotseat.io.
      MESSAGE
      stub_text_message_send(phone:, message:)

      sign_in create(:user, admin: true)
      perform_enqueued_jobs do
        patch "/admin/reviews/#{review.id}", params: {
          button: "rejected",
        }
      end

      review.reload
      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :rejected?
      assert_equal 0, reviewer.notification_token_count
      assert_text_message_send(phone:, message:)
    end

    it "rejects a review with a rejection reason" do
      create_current_term
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 0, phone:)
      review = create(:review, user: reviewer)
      rejection_reason = "Wrong professor for course"

      message = <<~MESSAGE
        Your Hotseat review for #{review.section.course_title} was not approved for the following reason: #{rejection_reason}

        No worries! You can update and resubmit your review at #{edit_review_url(review)} or reach out to reviews@hotseat.io.
      MESSAGE
      stub_text_message_send(phone:, message:)

      sign_in create(:user, admin: true)
      perform_enqueued_jobs do
        patch "/admin/reviews/#{review.id}", params: {
          button: "rejected",
          rejection_reason:,
        }
      end

      review.reload
      reviewer.reload

      assert_response :found
      assert_redirected_to(admin_review_path(review))
      assert_predicate review, :rejected?
      assert_equal 0, reviewer.notification_token_count
      assert_text_message_send(phone:, message:)
    end
  end
end
