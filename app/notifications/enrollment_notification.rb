# typed: strict
# frozen_string_literal: true

# To deliver this notification:
#
# EnrollmentNotification.with(post: @post).deliver_later(current_user)
# EnrollmentNotification.with(post: @post).deliver(current_user)

class EnrollmentNotification < Noticed::Base
  extend T::Sig
  # TODO: change this line?
  T.unsafe(self).include(Rails.application.routes.url_helpers)

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

    message = "Hotseat Alert: #{section.course_title} enrollment status changed from #{old_enrollment_status} to #{new_enrollment_status}."
    message << "\n\nEnroll now: #{enroll_url(section.id)}" if (section.enrollment_status == "Open") || (section.enrollment_status == "Waitlist")
    message << "\n\nAlready enrolled? Unsubscribe: #{unsubscribe_url(section.id)}"

    message.strip
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
