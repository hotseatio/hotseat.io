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
  deliver_by :aws_text_message, class: "DeliveryMethods::AwsTextMessage"

  # Add required params
  param :section
  param :previous_enrollment_numbers

  sig { returns(String) }
  def message
    old_enrollment_status = params[:previous_enrollment_numbers]["enrollment_status"]
    section = params[:section]
    new_enrollment_status = section.enrollment_status

    <<~MESSAGE
      Hotseat Alert: #{section.course_title} enrollment status changed from #{old_enrollment_status} to #{new_enrollment_status}.

      Enroll now: https://hotseat.io/enroll/#{section.id}

      Already enrolled? Unsubscribe: https://hotseat.io/unsubscribe/#{section.id}
    MESSAGE
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
