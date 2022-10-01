# typed: strict
# frozen_string_literal: true

module InstructorHelper
  extend T::Sig

  sig { params(instructor: Instructor).returns(String) }
  def instructor_description(instructor)
    "Find reviews and classes taught by professor #{instructor.full_label} in #{instructor.subject_areas.pluck(:name).to_sentence}. Provided by Hotseat, UCLA's premier source on course information."
  end
end
