# typed: strict
# frozen_string_literal: true

class EnrollmentNotificationsController < ApplicationController
  class CreateParams < T::Struct
    const :id, Integer
  end

  sig { void }
  def create
    typed_params = TypedParams[CreateParams].new.extract!(params)
    section = Section.find(typed_params.id)

    section.relationships.where(notify: true).each do |relationship|
      EnrollmentNotification.with(section:).deliver_later(relationship.user)
    end
  end
end
