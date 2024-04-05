# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :answers do |t|
      t.text :text, null: false
      t.date :answered_on, null: false

      t.string :question_number, null: false, index: true
      t.foreign_key :questions, column: :question_number, primary_key: :number
      t.text :question_text, null: false

      t.references :guest_interview_profile, null: false, foreign_key: true, index: true
      t.references :guest, null: false, foreign_key: true

      t.timestamps
    end
  end
end
