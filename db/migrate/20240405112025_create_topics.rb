# frozen_string_literal: true

class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics, id: false, primary_key: :code do |t|
      t.primary_key :code, :string, null: false
      t.string :name, null: false

      t.integer :display_order, null: false, index: { unique: true }
      t.check_constraint 'display_order > 0'
    end
  end
end
