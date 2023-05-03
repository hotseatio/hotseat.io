# typed: false
# frozen_string_literal: true

# To deliver this notification:
#
# EnrollmentNotification.with(post: @post).deliver_later(current_user)
# EnrollmentNotification.with(post: @post).deliver(current_user)

class EnrollmentNotification < Noticed::Base
  extend T::Sig
  # include GeneratedUrlHelpers
  # include Rails.application.routes.url_helpers
  # include GeneratedUrlHelpers

  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  deliver_by :aws_text_message, class: "DeliveryMethods::AwsTextMessage"
  deliver_by :web_push, class: "DeliveryMethods::WebPush"

  # Add required params
  param :section
  param :previous_enrollment_numbers
  param :timestamp

  sig { returns(String) }
  def full_message
    old_enrollment_status = params[:previous_enrollment_numbers]["enrollment_status"]
    section = params[:section]
    new_enrollment_status = section.enrollment_status

    message = "Hotseat Alert: #{section.course_title} enrollment status changed from #{old_enrollment_status} to #{new_enrollment_status}."
    message << "\n\nEnroll now: #{enroll_url(section.id)}" if (section.enrollment_status == "Open") || (section.enrollment_status == "Waitlist")
    message << "\n\nAlready enrolled? Unsubscribe: #{unsubscribe_url(section.id)}"

    message.strip
  end

  sig { returns(String) }
  def title
    section = params[:section]
    section.course_title
  end

  sig { returns(String) }
  def body
    old_enrollment_status = params[:previous_enrollment_numbers]["enrollment_status"]
    section = params[:section]
    new_enrollment_status = section.enrollment_status

    "Enrollment status changed from #{old_enrollment_status} to #{new_enrollment_status}."
  end

  sig { returns(String) }
  def tag
    section = params[:section]
    timestamp = params[:timestamp]
    "#{section.id}-#{timestamp}"
  end

  sig { returns(String) }
  def enroll_link
    section = params[:section]
    enroll_url(section.id)
  end

  sig { returns(String) }
  def unsubscribe_link
    section = params[:section]
    unsubscribe_url(section.id)
  end

  sig { returns(String) }
  def manage_link
    my_courses_url
  end

  sig { returns(String) }
  def enrollment_status
    section = params[:section]
    section.enrollment_status
  end
end
