# typed: true
# frozen_string_literal: true

class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table(:sections) do |t|
      t.references(:course, null: false, foreign_key: true)
      t.references(:term, null: false, foreign_key: true)
      t.string(:registrar_id, null: false)

      t.string(:days, null: false, array: true, default: [])
      t.string(:times, null: false, array: true, default: [])
      t.string(:locations, null: false, array: true, default: [])

      t.string(:units, null: false)
      t.text(:instructors, null: false, array: true, default: [])

      t.string(:enrollment_status, null: false)
      t.integer(:enrollment_count, null: false)
      t.integer(:enrollment_capacity, null: false)

      t.string(:waitlist_status, null: false)
      t.integer(:waitlist_count, null: false)
      t.integer(:waitlist_capacity, null: false)

      t.timestamps
      t.index(%i[registrar_id term_id], unique: true)
    end
  end
end
