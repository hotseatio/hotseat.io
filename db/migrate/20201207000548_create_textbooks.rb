# typed: true
# frozen_string_literal: true

class CreateTextbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :textbooks do |t|
      t.string :isbn, null: false
      t.string :title, null: false
      t.string :author
      t.boolean :is_required
      t.integer :edition, limit: 2
      t.string :copyright_year

      t.timestamps
      t.index :isbn, unique: true
    end

    create_join_table :textbooks, :sections, column_options: { foreign_key: true } do |t|
      t.index %i[section_id textbook_id], unique: true
    end
  end
end
