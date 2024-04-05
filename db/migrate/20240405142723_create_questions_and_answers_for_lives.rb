# frozen_string_literal: true

class CreateQuestionsAndAnswersForLives < ActiveRecord::Migration[7.1]
  def change
    create_view :questions_and_answers_for_lives
  end
end
