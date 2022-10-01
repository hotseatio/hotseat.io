# typed: true
# frozen_string_literal: true

class AddSummerSessionType < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          ALTER TYPE summer_session ADD VALUE 'V';
        SQL
      end

      dir.down do
        execute <<-SQL.squish
          ALTER TYPE summer_session RENAME TO summer_session_old;
          CREATE TYPE summer_session AS ENUM ('A', 'B', 'C', 'D');
          DROP TYPE summer_session_old;
        SQL
      end
    end
  end
end
