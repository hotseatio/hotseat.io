# typed: true
# frozen_string_literal: true

class ChangeUserToBeOAuthable < ActiveRecord::Migration[6.1]
  def up
    change_table(:users, bulk: true) do |t|
      t.remove(:encrypted_password,
               :reset_password_token,
               :reset_password_sent_at,
               :confirmation_token,
               :confirmed_at,
               :confirmation_sent_at,
               :unconfirmed_email)

      # Omniauthable
      t.string(:provider)
      t.string(:uid)

      t.string(:remember_token)
    end

    change_column(:users, :name, :string, null: false)

    add_index(:users, %i[uid provider], unique: true)
  end

  def down
    change_table(:users, bulk: true) do |t|
      t.remove(:provider, :uid, :remember_token)

      # Database authenticatable
      t.string(:encrypted_password, null: false, default: '')

      # Recoverable
      t.string(:reset_password_token)
      t.datetime(:reset_password_sent_at)

      ## Confirmable
      t.string(:confirmation_token)
      t.datetime(:confirmed_at)
      t.datetime(:confirmation_sent_at)
      t.string(:unconfirmed_email) # Only if using reconfirmable
    end

    change_column(:users, :name, :string)
  end
end
