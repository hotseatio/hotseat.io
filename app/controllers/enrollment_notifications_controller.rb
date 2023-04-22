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

    section.relationships.where(notify: true).each do |relationship|
      EnrollmentNotification.with(section:, previous_enrollment_numbers: typed_params.previous_enrollment_numbers.serialize).deliver_later(relationship.user)
    end

    render(json: { success: true })
  end

  private

  sig { void }
  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      # Compare the tokens in a time-constant manner, to mitigate
      # timing attacks.
      ActiveSupport::SecurityUtils.secure_compare(token, "NOTIFICATION_API_TOKEN")
    end
  end
end