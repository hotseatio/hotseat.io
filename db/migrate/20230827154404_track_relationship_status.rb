# typed: true
# frozen_string_literal: true

class TrackRelationshipStatus < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE relationship_status AS ENUM ('planned', 'subscribed', 'enrolled');
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE relationship_status;
        SQL
      end
    end

    change_table(:relationships, bulk: true) do |t|
      # Will make this non-null in a future migration
      t.column(:status, :relationship_status)
    end
  end
end
