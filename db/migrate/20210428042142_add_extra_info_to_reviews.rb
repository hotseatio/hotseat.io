# typed: true
# frozen_string_literal: true

class AddExtraInfoToReviews < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          CREATE TYPE final_type AS ENUM ('none', '10th', 'finals');
        SQL
      end

      dir.down do
        execute <<-SQL.squish
          DROP TYPE final_type;
        SQL
      end
    end

    change_table :reviews, bulk: true do |t|
      t.boolean :has_group_project
      t.boolean :requires_attendance
      t.integer :midterm_count
      t.column :final, :final_type

      t.boolean :reccomend_textbook
    end
  end
end
