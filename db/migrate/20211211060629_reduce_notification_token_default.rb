# typed: true
# frozen_string_literal: true

class ReduceNotificationTokenDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :notification_token_count, from: 4, to: 2)
  end
end
