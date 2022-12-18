# typed: true
# frozen_string_literal: true

class AddDescriptionAndUnitsToCourses < ActiveRecord::Migration[6.1]
  def change
    change_table(:courses, bulk: true) do |t|
      t.string(:description)
      t.string(:units)
    end

    # Since we track units in courses, the sections column is redundant.
    remove_column(:sections, :units, :string)
  end
end
