# typed: true
# frozen_string_literal: true

class DeliveryMethods::AwsTextMessage < Noticed::DeliveryMethods::Base
  extend T::Sig

  sig { returns(T::Hash[Symbol, T.untyped]) }
  attr_reader :params

  sig { returns(User) }
  attr_reader :recipient

  sig { returns(EnrollmentNotification) }
  attr_reader :notification

  sig { void }
  def deliver
    client = Aws::SNS::Client.new(
      region: "us-east-1",
      # ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY']
      # credentials: credentials,
    )

    Rails.logger.warn(notification.message)

    message = "test" # T.let(params[:message], String)
    if T.unsafe(Rails.env).production?
      response = client.publish({ phone_number: recipient.phone, message: })
      Rails.logger.info("Message sent! #{response.message_id}")
    else
      Rails.logger.info("Skipping sending message since we're not in production.")
    end
  end

  # You may override this method to validate options for the delivery method
  # Invalid options should raise a ValidationError
  #
  # def self.validate!(options)
  #   raise ValidationError, "required_option missing" unless options[:required_option]
  # end
end
