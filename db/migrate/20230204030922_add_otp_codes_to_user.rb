# typed: true
# frozen_string_literal: true

class AddOtpCodesToUser < ActiveRecord::Migration[7.0]
  def change
    change_table(:users, bulk: true) do |t|
      t.string(:phone_verification_otp_secret, limit: 32, null: true)
    end
  end
end
