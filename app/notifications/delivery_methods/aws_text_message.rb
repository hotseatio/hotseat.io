# typed: true
# frozen_string_literal: true

class DeliveryMethods::AwsTextMessage < Noticed::DeliveryMethods::Base
  extend T::Sig

  sig { returns(T::Hash[Symbol, T.untyped]) }
  attr_reader :params

  sig { returns(User) }
  attr_reader :recipient

  sig { returns(T.any(EnrollmentNotification, ReviewApprovedNotification, ReviewRejectedNotification)) }
  attr_reader :notification

  sig { void }
  def deliver
    if recipient.phone.nil?
      Rails.logger.error("User does not have phone number! user=#{recipient.id}")
      return
    end

    client = Aws::SNS::Client.new(region: "us-east-1")

    if Rails.env.development?
      Rails.logger.info("Skipping sending message since we're not in production.")
    else
      response = client.publish({ phone_number: recipient.phone, message: notification.full_message })
      Rails.logger.info("Message sent! #{response.message_id}")
    end
  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
