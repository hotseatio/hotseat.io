# typed: true
# frozen_string_literal: true

class CreatePayTables < ActiveRecord::Migration[6.0]
  def change
    create_table(:pay_customers) do |t|
      t.belongs_to(:owner, polymorphic: true, index: false)
      t.string(:processor, null: false)
      t.string(:processor_id)
      # rubocop:disable Rails/ThreeStateBooleanColumn
      t.boolean(:default)
      # rubocop:enable Rails/ThreeStateBooleanColumn
      t.public_send(Pay::Adapter.json_column_type, :data)
      t.datetime(:deleted_at)
      t.timestamps
    end
    add_index(:pay_customers, %i[owner_type owner_id deleted_at default], name: :pay_customer_owner_index)
    add_index(:pay_customers, %i[processor processor_id], unique: true)

    create_table(:pay_merchants) do |t|
      t.belongs_to(:owner, polymorphic: true, index: false)
      t.string(:processor, null: false)
      t.string(:processor_id)
      # rubocop:disable Rails/ThreeStateBooleanColumn
      t.boolean(:default)
      # rubocop:enable Rails/ThreeStateBooleanColumn
      t.public_send(Pay::Adapter.json_column_type, :data)
      t.timestamps
    end
    add_index(:pay_merchants, %i[owner_type owner_id processor])

    create_table(:pay_payment_methods) do |t|
      t.belongs_to(:customer, foreign_key: { to_table: :pay_customers }, null: false, index: false)
      t.string(:processor_id, null: false)
      # rubocop:disable Rails/ThreeStateBooleanColumn
      t.boolean(:default)
      # rubocop:enable Rails/ThreeStateBooleanColumn
      t.string(:type)
      t.public_send(Pay::Adapter.json_column_type, :data)
      t.timestamps
    end
    add_index(:pay_payment_methods, %i[customer_id processor_id], unique: true)

    create_table(:pay_subscriptions) do |t|
      t.belongs_to(:customer, foreign_key: { to_table: :pay_customers }, null: false, index: false)
      t.string(:name, null: false)
      t.string(:processor_id, null: false)
      t.string(:processor_plan, null: false)
      t.integer(:quantity, default: 1, null: false)
      t.string(:status, null: false)
      t.datetime(:trial_ends_at)
      t.datetime(:ends_at)
      t.decimal(:application_fee_percent, precision: 8, scale: 2)
      t.public_send(Pay::Adapter.json_column_type, :metadata)
      t.public_send(Pay::Adapter.json_column_type, :data)
      t.timestamps
    end
    add_index(:pay_subscriptions, %i[customer_id processor_id], unique: true)

    create_table(:pay_charges) do |t|
      t.belongs_to(:customer, foreign_key: { to_table: :pay_customers }, null: false, index: false)
      t.belongs_to(:subscription, foreign_key: { to_table: :pay_subscriptions }, null: true)
      t.string(:processor_id, null: false)
      t.integer(:amount, null: false)
      t.string(:currency)
      t.integer(:application_fee_amount)
      t.integer(:amount_refunded)
      t.public_send(Pay::Adapter.json_column_type, :metadata)
      t.public_send(Pay::Adapter.json_column_type, :data)
      t.timestamps
    end
    add_index(:pay_charges, %i[customer_id processor_id], unique: true)

    create_table(:pay_webhooks) do |t|
      t.string(:processor)
      t.string(:event_type)
      t.public_send(Pay::Adapter.json_column_type, :event)
      t.timestamps
    end
  end
end
