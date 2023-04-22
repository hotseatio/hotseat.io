# typed: strict
# frozen_string_literal: true

# To deliver this notification:
#
# EnrollmentNotification.with(post: @post).deliver_later(current_user)
# EnrollmentNotification.with(post: @post).deliver(current_user)

class EnrollmentNotification < Noticed::Base
  extend T::Sig

  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  param :section
  param :previous_enrollment_numbers

  # sig { returns(String) }
  # def message
  #   params

  #   <<~EOS
  #     Hotseat Alert: #{section} enrollment status changed from  to

  #     Enroll now: https://hotseat.io/enroll/%d

  #     Already enrolled? Unsubscribe: https://hotseat.io/unsubscribe/%d
  #   EOS
  # end
  #
  # def url
  #   post_path(params[:post])
  # end
end
