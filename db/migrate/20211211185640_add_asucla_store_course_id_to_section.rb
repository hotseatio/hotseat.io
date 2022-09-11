# typed: true
# frozen_string_literal: true

class AddAsuclaStoreCourseIdToSection < ActiveRecord::Migration[6.1]
  def change
    change_table :sections, bulk: true do |t|
      t.string :asucla_id
    end
  end
end
