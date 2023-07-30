# typed: strict
# frozen_string_literal: true

# To deliver this notification:
#
# ReviewRejectedNotification.with(post: @post).deliver_later(current_user)
# ReviewRejectedNotification.with(post: @post).deliver(current_user)

class ReviewRejectedNotification < Noticed::Base
  extend T::Sig

  deliver_by :aws_text_message, class: "DeliveryMethods::AwsTextMessage"

  sig { returns(String) }
  def full_message
    review = params[:review]
    rejection_reason = params[:rejection_reason]

    message = if rejection_reason.blank?
                <<~MESSAGE
                  Your Hotseat review for #{review.section.course_title} was not approved. No worries! You can update and resubmit your review here: #{edit_review_url(review)}
                MESSAGE
              else
                <<~MESSAGE
                  Your Hotseat review for #{review.section.course_title} was not approved for the following reason: #{rejection_reason}

                  No worries! You can update and resubmit your review at #{edit_review_url(review)} or reach out to reviews@hotseat.io.
                MESSAGE
              end

    message.strip
  end
end
