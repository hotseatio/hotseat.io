# typed: true
# frozen_string_literal: true

class CreateInstructors < ActiveRecord::Migration[6.1]
  def change
    create_table(:instructors) do |t|
      t.string(:first_name, null: false)
      t.string(:last_name, null: false)
      t.references(:subject_area, null: false, foreign_key: true)

      t.timestamps
      t.index(%i[first_name last_name subject_area_id], unique: true, name: "index_instructors_on_name_and_subject_area_id")
    end

    create_join_table(:instructors, :sections, column_options: { foreign_key: true }) do |t|
      t.index(%i[instructor_id section_id], unique: true)
    end
  end
end
