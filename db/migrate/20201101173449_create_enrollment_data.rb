# typed: true
# frozen_string_literal: true

class CreateEnrollmentData < ActiveRecord::Migration[6.0]
  def change
    create_table :enrollment_data do |t|
      t.references :section, null: false, foreign_key: true

      t.string :enrollment_status, null: false
      t.integer :enrollment_count, null: false
      t.integer :enrollment_capacity, null: false

      t.string :waitlist_status, null: false
      t.integer :waitlist_count, null: false
      t.integer :waitlist_capacity, null: false

      t.timestamps
      t.index %i[section_id created_at]
    end
  end
end
