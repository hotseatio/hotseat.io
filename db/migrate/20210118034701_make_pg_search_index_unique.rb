# typed: false
# frozen_string_literal: true

class MakePgSearchIndexUnique < ActiveRecord::Migration[6.1]
  extend T::Sig

  sig { void }
  def change
    change_table(:pg_search_documents, bulk: true) do |t|
      name = :index_pg_search_documents_on_searchable
      t.remove_index(%i[searchable_type searchable_id], name:)
      t.index        %i[searchable_type searchable_id], name:, unique: true
    end
  end
end
