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
    recipient.webpush_devices.each(&:send_push)
  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
