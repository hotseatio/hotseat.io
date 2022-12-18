# typed: true
# frozen_string_literal: true

class CreateGradeDistributions < ActiveRecord::Migration[6.1]
  def change
    create_table(:grade_distributions) do |t|
      t.belongs_to(:section,
                   index: { unique: true },
                   foreign_key: true)

      t.float(:percent_a_plus, null: false, default: 0)
      t.float(:percent_a, null: false, default: 0)
      t.float(:percent_a_minus, null: false, default: 0)
      t.float(:percent_b_plus, null: false, default: 0)
      t.float(:percent_b, null: false, default: 0)
      t.float(:percent_b_minus, null: false, default: 0)
      t.float(:percent_c_plus, null: false, default: 0)
      t.float(:percent_c, null: false, default: 0)
      t.float(:percent_c_minus, null: false, default: 0)
      t.float(:percent_d_plus, null: false, default: 0)
      t.float(:percent_d, null: false, default: 0)
      t.float(:percent_d_minus, null: false, default: 0)
      t.float(:percent_f, null: false, default: 0)

      t.timestamps
    end
  end
end
