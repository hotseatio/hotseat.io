# typed: true
# frozen_string_literal: true

class AddNotificationTokensToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :notification_token_count, :integer,
               limit: 2,
               default: 1,
               null: false

    reversible do |dir|
      dir.up do
        execute <<-SQL.squish
          ALTER TABLE users ADD CONSTRAINT notification_tokens_positive_count CHECK (notification_token_count >= 0);
        SQL
      end

      dir.down do
        execute <<-SQL.squish
          ALTER TABLE users DROP CONSTRAINT notification_tokens_positive_count;
        SQL
      end
    end
  end
end
