# typed: strict
# frozen_string_literal: true

class EnrollmentAppointment < ApplicationRecord
  validates :first, presence: true
  validates :last, presence: true

  belongs_to :term

  enum standing: {
    graduating_senior: "graduating_senior",
    almost_graduating_senior: "almost_graduating_senior",
    new_student: "new",
    readmitted: "readmitted",
    visiting: "visiting",
    senior: "senior",
    junior: "junior",
    sophomore: "sophomore",
    freshman: "freshman",
    joint_graduate: "joint_graduate",
    graduate: "graduate",
  }

  enum pass: {
    graduate_pass: "graduate",
    priority_pass: "priority",
    first_pass: "first",
    second_pass: "second",
  }
end
