# typed: strict
# frozen_string_literal: true

# To deliver this notification:
#
# ReviewRejectedNotification.with(post: @post).deliver_later(current_user)
# ReviewRejectedNotification.with(post: @post).deliver(current_user)

class ReviewApprovedNotification < Noticed::Base
  extend T::Sig

  deliver_by :aws_text_message, class: "DeliveryMethods::AwsTextMessage"

  sig { returns(String) }
  def full_message
    review = T.let(params[:review], Review)
    user = T.must(review.user)
    section = T.must(review.section)

    message = <<~MESSAGE
      Your Hotseat review for #{section.course_title} was approved. You now have #{user.notification_token_count} notification tokens.
    MESSAGE

    message.strip
  end
end
