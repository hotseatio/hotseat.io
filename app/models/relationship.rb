# typed: strict
# frozen_string_literal: true

class Relationship < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :section
  has_one :review, dependent: :restrict_with_exception

  #
  # enum current_status

  class Status < T::Enum
    enums do
      Planned = new
      Subscribed = new
      Enrolled = new

      Completed = new
      Reviewed = new
    end
  end

  sig { returns(Status) }
  def status
    # if review
    #   Reviewed
    # elsif section.term in the past
    #   Completed
    # else
    #   current_status
  end

  sig { returns(T::Boolean) }
  def reviewed?
    review.present?
  end

  sig { returns(T::Boolean) }
  def completed?
    section.term.enrollment_period == Term::EnrollmentPeriod::Post
  end
end
