# typed: true
# frozen_string_literal: true

class AddSupportForSummerSections < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE summer_session AS ENUM ('A', 'B', 'C', 'D');
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE summer_session;
        SQL
      end
    end

    # Add columns to `sections`
    change_table(:sections, bulk: true) do |t|
      t.column(:summer_session, :summer_session)
      t.integer(:summer_duration_weeks)
    end

    change_table(:terms, bulk: true) do |t|
      t.date(:session_a_start)
      t.date(:session_b_start)
      t.date(:session_c_start)
      t.date(:session_d_start)
    end
  end
end
