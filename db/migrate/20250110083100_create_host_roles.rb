# frozen_string_literal: true

class CreateHostRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :host_roles, id: false do |t|
      t.string :name, index: { unique: true }, null: false
    end

    add_column :hosts, :role_name, :string, null: false, default: 'regular'
    change_column_default :hosts, :role_name, from: 'regular', to: nil
    add_foreign_key :hosts, :host_roles, column: :role_name, primary_key: :name
  end
end
