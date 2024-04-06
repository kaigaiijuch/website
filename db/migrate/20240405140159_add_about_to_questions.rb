# frozen_string_literal: true

class AddAboutToQuestions < ActiveRecord::Migration[7.1]
  def up
    add_column :questions, :about, :string
    execute 'UPDATE questions SET about = text'
    change_column_null :questions, :about, false
  end

  def down
    remove_column :questions, :about
  end
end
