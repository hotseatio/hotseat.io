# typed: strict
# frozen_string_literal: true

class EnrollmentNotificationsController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token

  class PreviousEnrollmentNumbers < T::Struct
    const :enrollment_status, String
    const :enrollment_count, Integer
    const :enrollment_capacity, Integer
    const :waitlist_status, String
    const :waitlist_count, Integer
    const :waitlist_capacity, Integer
  end

  class CreateParams < T::Struct
    const :section_id, Integer
    const :previous_enrollment_numbers, PreviousEnrollmentNumbers
  end

  sig { void }
  def create
    Rails.logger.debug(params)
    typed_params = TypedParams[CreateParams].new.extract!(params)
    section = Section.find(typed_params.section_id)

    # if !section.enrollable?
    #   render(json: { not_enrollable: true, notifications_sent: 0 })
    #   return
    # end

    timestamp = Time.now.to_i
    subscriptions = section.relationships.where(notify: true)
    subscriptions.each do |relationship|
      EnrollmentNotification.with(timestamp:, section:, previous_enrollment_numbers: typed_params.previous_enrollment_numbers.serialize).deliver_later(relationship.user)
    end

    render(json: { notifications_sent: subscriptions.size })
  end

  private

  sig { void }
  def authenticate
    expected_token = ENV.fetch("ENROLLMENT_NOTIFICATION_API_TOKEN")
    authenticate_or_request_with_http_token do |token, _options|
      ActiveSupport::SecurityUtils.secure_compare(token, expected_token)
    end
  end
end
