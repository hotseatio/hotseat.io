# typed: true
# frozen_string_literal: true

class AddDatesToTerm < ActiveRecord::Migration[6.1]
  def change
    change_table(:terms, bulk: true) do |t|
      t.date(:start_date)
      t.date(:end_date)
    end
  end
end
