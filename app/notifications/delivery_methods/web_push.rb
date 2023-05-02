# typed: true
# frozen_string_literal: true

class DeliveryMethods::WebPush < Noticed::DeliveryMethods::Base
  extend T::Sig

  sig { returns(T::Hash[Symbol, T.untyped]) }
  attr_reader :params

  sig { returns(User) }
  attr_reader :recipient

  sig { returns(EnrollmentNotification) }
  attr_reader :notification

  sig { void }
  def deliver
    push_notification = WebpushDevice::PushNotification.new(
      title: notification.title,
      body: notification.body,
      tag: notification.tag,
      status: notification.enrollment_status,
      actions: [
        WebpushDevice::Action.new(
          action: notification.enroll_link,
          title: "Enroll",
        ),
        WebpushDevice::Action.new(
          action: notification.unsubscribe_link,
          title: "Unsubscribe",
        ),
        WebpushDevice::Action.new(
          action: notification.manage_link,
          title: "Manage",
        ),
      ],
    )

    recipient.webpush_devices.each do |device|
      device.send_push(push_notification)
    end
  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
