# typed: true
# frozen_string_literal: true

# Partially generated from
#  rails g pg_search:migration:multisearch
# See https://github.com/Casecommons/pg_search#setup.

class CreatePgSearchDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :pg_search_documents do |t|
      t.text :content
      t.belongs_to :searchable, polymorphic: true, index: true
      t.timestamps null: false

      # Add a GIN index to speed up search. The expression is found by doing a
      # PgSearch.multisearch and observing the generated query.
      # See https://www.postgresql.org/docs/current/textsearch-tables.html#TEXTSEARCH-TABLES-INDEX
      t.index "to_tsvector('simple', coalesce(content, ''))", name: :index_pg_search_documents_on_to_tsvector_simple_content, using: :gin
    end
  end
end
