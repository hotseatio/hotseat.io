# typed: true
# frozen_string_literal: true

class AddGradesToReviews < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE grade_type AS ENUM (
          'A+',
          'A',
          'A-',
          'B+',
          'B',
          'B-',
          'C+',
          'C',
          'C-',
          'D+',
          'D',
          'D-',
          'F',
          'P',
          'NP'
          );
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE grade_type;
        SQL
      end
    end

    change_table(:reviews) do |t|
      t.column(:grade, :grade_type)
    end
  end
end
