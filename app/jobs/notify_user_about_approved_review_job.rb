# typed: strict
# frozen_string_literal: true

require "aws-sdk-sns"

class NotifyUserAboutApprovedReviewJob < ApplicationJob
  extend T::Sig
  queue_as :default

  sig { params(review: Review).void }
  def perform(review)
    logger.info("Starting NotifyUserAboutApprovedReviewJob")
    user = T.must(review.user)
    section = T.must(review.section)

    if user.phone.nil?
      logger.warn("User #{user.id} does not have a phone number")
      return
    end

    message = <<~MESSAGE
      Your Hotseat review for #{section.course_title} was approved. You now have #{user.notification_token_count} notification tokens.
    MESSAGE

    client = Aws::SNS::Client.new
    resp = client.publish({
                            phone_number: user.phone,
                            message:,
                          })
    logger.info("Message sent. Message id: #{resp.message_id}")
  end
end
