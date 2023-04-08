# typed: true
# frozen_string_literal: true

class CreateWebpushDevices < ActiveRecord::Migration[7.0]
  def change
    create_table(:webpush_devices) do |t|
      t.belongs_to(:user, foreign_key: true)
      t.string(:nickname)
      t.string(:browser, null: false)
      t.string(:device, null: false)
      t.string(:operating_system, null: false)
      t.string(:notification_endpoint, null: false)

      t.timestamps
    end
  end
end
