# typed: true
# frozen_string_literal: true

class AddIndexToCoursesTitleNumberAndSubjectArea < ActiveRecord::Migration[6.0]
  def change
    add_index(:courses, %i[title number subject_area_id], unique: true)
  end
end
