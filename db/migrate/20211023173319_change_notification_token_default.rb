# typed: true
# frozen_string_literal: true

class ChangeNotificationTokenDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:users, :notification_token_count, from: 1, to: 4)
  end
end
