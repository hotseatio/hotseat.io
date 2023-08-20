# typed: true
# frozen_string_literal: true

class AddEnrollmentNotificationPreferences < ActiveRecord::Migration[7.0]
  def change
    change_table(:users, bulk: true) do |t|
      t.boolean(:enrollment_sms_notifications, null: false, default: true)
      t.boolean(:enrollment_web_push_notifications, null: false, default: true)
    end
  end
end
