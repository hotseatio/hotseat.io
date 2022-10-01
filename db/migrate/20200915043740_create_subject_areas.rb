# typed: true
# frozen_string_literal: true

class CreateSubjectAreas < ActiveRecord::Migration[6.0]
  def change
    create_table :subject_areas do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
