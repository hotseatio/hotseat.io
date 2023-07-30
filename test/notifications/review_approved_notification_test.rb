# typed: strict
# frozen_string_literal: true

require "test_helper"

class ReviewApprovedNotificationTest < ActiveSupport::TestCase
  describe "text messages" do
    it "sends a text message to a user" do
      phone = T.must(User.normalize_phone(Faker::PhoneNumber.cell_phone))
      reviewer = create(:user, notification_token_count: 1, phone:)
      review = create(:review, user: reviewer)
      section = review.section

      message = <<~MESSAGE
        Your Hotseat review for #{section.course_title} was approved. You now have 1 notification tokens.
      MESSAGE
      stub_text_message_send(message:, phone:)

      ReviewApprovedNotification.with(review:).deliver(reviewer)
      assert_text_message_send(message:, phone:)
    end
  end
end
