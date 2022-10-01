# typed: true
# frozen_string_literal: true

class TrackDeprecatedSubjectAreasAndCourses < ActiveRecord::Migration[6.1]
  def change
    change_table :subject_areas do |t|
      t.references :superseding_subject_area, foreign_key: { to_table: :subject_areas }
    end

    change_table :courses do |t|
      t.references :superseding_course, foreign_key: { to_table: :courses }
    end
  end
end
