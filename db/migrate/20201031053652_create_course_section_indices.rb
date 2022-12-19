# typed: true
# frozen_string_literal: true

class CreateCourseSectionIndices < ActiveRecord::Migration[6.0]
  def change
    create_table(:course_section_indices) do |t|
      t.references(:course, null: false, foreign_key: true)
      t.references(:term, null: false, foreign_key: true)
      t.text(:indices, null: false, array: true, default: [])
      t.timestamps
      t.index(%i[course_id term_id], unique: true)
    end
  end
end
