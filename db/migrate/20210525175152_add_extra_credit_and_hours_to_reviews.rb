# typed: true
# frozen_string_literal: true

class AddExtraCreditAndHoursToReviews < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        execute(<<-SQL.squish)
          CREATE TYPE weekly_time_type AS ENUM ('0-5', '5-10', '10-15', '15-20', '20+');
        SQL
      end

      dir.down do
        execute(<<-SQL.squish)
          DROP TYPE weekly_time_type;
        SQL
      end
    end

    remove_column(:reviews, :difficulty, :integer)
    change_table(:reviews, bulk: true) do |t|
      t.column(:weekly_time, :weekly_time_type)
      # rubocop:disable Rails/ThreeStateBooleanColumn
      t.boolean(:offers_extra_credit)
      # rubocop:enable Rails/ThreeStateBooleanColumn
    end
  end
end
