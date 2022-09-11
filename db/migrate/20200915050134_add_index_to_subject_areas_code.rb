# typed: true
# frozen_string_literal: true

class AddIndexToSubjectAreasCode < ActiveRecord::Migration[6.0]
  def change
    add_index :subject_areas, :code, unique: true
  end
end
