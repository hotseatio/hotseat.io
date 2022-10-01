# typed: true
# frozen_string_literal: true

class SetSubjectAreasNameAndCodeNotNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:subject_areas, :name, false)
    change_column_null(:subject_areas, :code, false)
  end
end
