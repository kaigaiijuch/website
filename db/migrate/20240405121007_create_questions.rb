# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions, id: false, primary_key: :numer do |t|
      t.primary_key :number, :string, null: false
      t.text :text, null: false
      t.integer :display_order, null: false
      t.string :topic_code, null: false
      t.timestamps

      t.index %i[topic_code display_order], unique: true
      t.foreign_key :topics, column: :topic_code, primary_key: :code
      t.check_constraint 'display_order > 0'
    end
  end
end
