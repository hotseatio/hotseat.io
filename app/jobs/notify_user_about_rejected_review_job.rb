# typed: false
# frozen_string_literal: true

require "aws-sdk-sns"

class NotifyUserAboutRejectedReviewJob < ApplicationJob
  extend T::Sig
  # I'd like to use `include GeneratedUrlHelpers` here, but we run into errors when testing
  T.unsafe(self).include(Rails.application.routes.url_helpers)

  queue_as :default

  sig { params(review: Review).void }
  def perform(review)
    logger.info("Starting NotifyUserAboutRejectedReviewJob")
    user = T.must(review.user)
    section = T.must(review.section)

    if user.phone.nil?
      logger.warn("User #{user.id} does not have a phone number")
      return
    end

    message = <<~MESSAGE
      Your Hotseat review for #{section.course_title} was not approved. No worries! You can update and resubmit your review here: #{edit_review_url(review)}
    MESSAGE

    client = Aws::SNS::Client.new
    resp = client.publish({
                            phone_number: user.phone,
                            message:,
                          })
    logger.info("Message sent. Message id: #{resp.message_id}")
  end
end
