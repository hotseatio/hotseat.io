# typed: true
# frozen_string_literal: true

class CreateWebpushDevices < ActiveRecord::Migration[7.0]
  def change
    create_table(:webpush_devices) do |t|
      t.belongs_to(:user, foreign_key: true)

      # Metadata
      t.string(:nickname)
      t.string(:browser, null: false)
      t.string(:operating_system, null: false)

      # The notification stuff
      t.string(:notification_endpoint, null: false, index: { unique: true })
      t.string(:auth_key, null: false)
      t.string(:p256dh_key, null: false)

      t.timestamps
    end
  end
end
