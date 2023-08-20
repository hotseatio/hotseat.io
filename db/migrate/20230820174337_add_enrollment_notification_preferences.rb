# typed: true
# frozen_string_literal: true

class AddEnrollmentNotificationPreferences < ActiveRecord::Migration[7.0]
  def change
    change_table(:users, bulk: true) do |t|
      t.boolean(:send_enrollment_sms, null: false, default: true)
      t.boolean(:send_enrollment_web_push, null: false, default: true)
    end
  end
end
