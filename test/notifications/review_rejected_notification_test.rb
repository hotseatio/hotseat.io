# typed: strict
# frozen_string_literal: true

require "test_helper"

class ReviewRejectedNotificationTest < ActiveSupport::TestCase
  describe "text messages" do
    it "sends a text message to a user" do
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 1, phone:)
      review = create(:review, user: reviewer)
      section = review.section

      message = <<~MESSAGE
        Your Hotseat review for #{section.course_title} was not approved. No worries! You can update and resubmit your review at http://localhost:3000/reviews/#{review.id}/edit or reach out to reviews@hotseat.io.
      MESSAGE
      stub_text_message_send(message:, phone:)

      ReviewRejectedNotification.with(review:).deliver(reviewer)
      assert_text_message_send(message:, phone:)
    end

    it "sends a text message to a user with a rejection reason" do
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 1, phone:)
      review = create(:review, user: reviewer)
      section = review.section

      message = <<~MESSAGE
        Your Hotseat review for #{section.course_title} was not approved for the following reason: wrong instructor for course

        No worries! You can update and resubmit your review at http://localhost:3000/reviews/#{review.id}/edit or reach out to reviews@hotseat.io.
      MESSAGE
      stub_text_message_send(message:, phone:)

      ReviewRejectedNotification.with(review:, rejection_reason: "wrong instructor for course").deliver(reviewer)
      assert_text_message_send(message:, phone:)
    end
  end
end
