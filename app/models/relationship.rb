# typed: strict
# frozen_string_literal: true

class Relationship < ApplicationRecord
  extend T::Sig

  belongs_to :user
  belongs_to :section
  has_one :review, dependent: :restrict_with_exception

  enum stored_status: {
    planned: "planned",
    subscribed: "subscribed",
    enrolled: "enrolled",
  }

  class Status < T::Enum
    enums do
      # A relationship can be in one of the following states:
      Planned = new("planned") # A user has put this section into their class plan for a quarter
      Subscribed = new("subscribed") # The section is in a class plan and the user wants enrollment notifications for the section
      Enrolled = new("enrolled") # The section has been enrolled in. No need to send further notifications.

      Completed = new("completed") # Where enrolled sections go after the quarter ends. The user has taken the course!
      Reviewed = new("reviewed") # The user has taken the section and reviewed it.

      # How does Status differ from stored_status above? We track the first three states (planned, subscribed, enrolled) in the database on this relationship model. The other two states (completed, reviewed) are derived based off other information (term calendar and if a review was written, respectively).
    end
  end

  sig { returns(Status) }
  def status
    if reviewed?
      Status::Reviewed
    elsif completed?
      Status::Completed
    else
      Status.deserialize(stored_status)
    end
  end

  sig { returns(T::Boolean) }
  def reviewed?
    review.present?
  end

  sig { returns(T::Boolean) }
  def completed?
    section&.term&.enrollment_period == Term::EnrollmentPeriod::Post
  end

  sig { returns(T::Boolean) }
  def reviewed_or_completed?
    reviewed? || completed?
  end
end
