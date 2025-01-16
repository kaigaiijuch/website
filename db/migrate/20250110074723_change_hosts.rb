# frozen_string_literal: true

class ChangeHosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :hosts, :english_name, :string, null: false
    remove_column :hosts, :nickname, :string, null: false

    add_column :hosts, :url, :string
    add_column :hosts, :title, :string, null: false, default: ''
    add_column :hosts, :description, :string

    change_column_default :hosts, :title, from: '', to: nil
  end
end
