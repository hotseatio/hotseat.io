# typed: true
# frozen_string_literal: true

class CreateTerms < ActiveRecord::Migration[6.0]
  def change
    create_table :terms do |t|
      t.string :term, limit: 3, null: false
      t.timestamps
      t.index :term, unique: true
    end
  end
end
