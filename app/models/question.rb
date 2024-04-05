# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  display_order :integer          not null
#  number        :string           not null, primary key
#  text          :text             not null
#  topic_code    :string           not null
#
# Indexes
#
#  index_questions_on_topic_code_and_display_order  (topic_code,display_order) UNIQUE
#
# Foreign Keys
#
#  topic_code  (topic_code => topics.code)
#
class Question < ApplicationRecord
  belongs_to :topic, foreign_key: :topic_code, primary_key: :code, inverse_of: :questions
end
