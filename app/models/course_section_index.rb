# typed: strict
# frozen_string_literal: true

class CourseSectionIndex < ApplicationRecord
  belongs_to :course
  belongs_to :term
end
