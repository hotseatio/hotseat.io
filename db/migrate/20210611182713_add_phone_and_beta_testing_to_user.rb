# typed: true
# frozen_string_literal: true

class AddPhoneAndBetaTestingToUser < ActiveRecord::Migration[6.1]
  def change
    change_table(:users, bulk: true) do |t|
      t.string(:phone)
      t.boolean(:beta_tester, null: false, default: false)
    end
  end
end
