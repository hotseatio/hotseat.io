# typed: true
# frozen_string_literal: true

class AddNotifyToRelationships < ActiveRecord::Migration[6.1]
  def change
    change_table(:relationships) do |t|
      t.boolean(:notify, null: false, default: false)
    end
  end
end
