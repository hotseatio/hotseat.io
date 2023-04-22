# typed: strict
# frozen_string_literal: true

class EnrollmentNotificationsController < ApplicationController
  before_action :authenticate
  skip_before_action :verify_authenticity_token

  class CreateParams < T::Struct
    const :section_id, Integer
  end

  sig { void }
  def create
    typed_params = TypedParams[CreateParams].new.extract!(params)
    section = Section.find(typed_params.section_id)

    section.relationships.where(notify: true).each do |relationship|
      EnrollmentNotification.with(section:).deliver_later(relationship.user)
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
