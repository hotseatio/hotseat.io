# typed: true
# frozen_string_literal: true

class DropSubjectAreasTerms < ActiveRecord::Migration[6.1]
  def change
    drop_join_table :subject_areas, :terms
  end
end
