# typed: true
# frozen_string_literal: true

class ChangeInstructors < ActiveRecord::Migration[6.1]
  def change
    drop_join_table(:instructors, :sections, column_options: { foreign_key: true }) do |t|
      t.index(%i[instructor_id section_id], unique: true)
    end

    drop_table(:instructors) do |t|
      t.string(:first_name, null: false)
      t.string(:last_name, null: false)
      t.references(:subject_area, null: false, foreign_key: true)

      t.timestamps
      t.index(%i[first_name last_name subject_area_id], unique: true, name: "index_instructors_on_name_and_subject_area_id")
    end

    create_table(:instructors) do |t|
      t.string(:first_names, null: false, array: true, default: [])
      t.string(:last_names, null: false, array: true, default: [])
      t.string(:preferred_label)

      t.timestamps
      t.index(%i[first_names last_names], unique: true, name: "index_instructors_on_names")
    end

    change_table(:sections) do |t|
      t.belongs_to(:instructor, index: true, foreign_key: true)
      t.boolean(:should_update_instructor, null: false, default: true)
    end
  end
end
