# typed: true
# frozen_string_literal: true

class AddSummerSessionType < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          ALTER TYPE summer_session ADD VALUE 'V';
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          ALTER TYPE summer_session RENAME TO summer_session_old;
          CREATE TYPE summer_session AS ENUM ('A', 'B', 'C', 'D');
          ALTER TABLE sections ALTER COLUMN summer_session TYPE summer_session USING summer_session::text::summer_session;
          DROP TYPE summer_session_old;
        SQL
      end
    end
  end
end
