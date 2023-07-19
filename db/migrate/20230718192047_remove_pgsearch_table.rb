# typed: true
# frozen_string_literal: true

class RemovePgsearchTable < ActiveRecord::Migration[7.0]
  def change
    drop_table(:pg_search_documents, if_exists: true) do |t|
      t.text(:content)
      t.belongs_to(:searchable, polymorphic: true, index: true)
      t.timestamps(null: false)
      t.index("to_tsvector('simple', coalesce(content, ''))", name: :index_pg_search_documents_on_to_tsvector_simple_content, using: :gin)
    end
  end
end
