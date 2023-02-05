# typed: true
# frozen_string_literal: true

class AddReferralsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table(:users, bulk: true) do |t|
      t.string(:referral_code)
      t.integer(:referred_by_id)
      t.datetime(:referral_completed_at)
      t.index(:referral_code, unique: true)
    end
  end
end
