# typed: false
# frozen_string_literal: true

class CreateReadOnlyBlazerUser < ActiveRecord::Migration[6.0]
  def up
    execute <<~SQL.squish
      CREATE ROLE blazer LOGIN PASSWORD 'c44jbR3qFYhsBXM8FKFrkm';
    SQL

    if Rails.env.production?
      execute 'GRANT CONNECT ON DATABASE hotseat TO blazer;'
    elsif Rails.env.test?
      execute 'GRANT CONNECT ON DATABASE hotseat_test TO blazer;'
    else
      execute 'GRANT CONNECT ON DATABASE hotseat_dev TO blazer;'
    end

    execute <<~SQL.squish
      GRANT USAGE ON SCHEMA public TO blazer;
      GRANT SELECT ON ALL TABLES IN SCHEMA public TO blazer;
      ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO blazer;
    SQL
  end

  def down
    execute <<~SQL.squish
      DROP OWNED BY blazer;
      DROP ROLE blazer;
    SQL
  end
end
