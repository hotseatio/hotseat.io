# typed: true
# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :number, null: false
      t.references :subject_area, null: false, foreign_key: true

      t.timestamps
    end
  end
end
