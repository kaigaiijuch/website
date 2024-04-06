# frozen_string_literal: true

class CreateQuestionsAndAnswers < ActiveRecord::Migration[7.1]
  def change
    create_view :questions_and_answers
  end
end
