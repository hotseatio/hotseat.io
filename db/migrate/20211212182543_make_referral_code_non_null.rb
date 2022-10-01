# typed: true
# frozen_string_literal: true

class MakeReferralCodeNonNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:users, :referral_code, false)
  end
end
