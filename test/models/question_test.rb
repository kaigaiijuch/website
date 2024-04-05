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
require 'test_helper'

# Test for the Question model
class QuestionTest < ActiveSupport::TestCase
  # Test case to check if the question belongs to a topic
  test 'should belong to a topic' do
    assert_equal questions(:one).topic, topics(:general)
    assert_equal topics(:general).questions.all, [questions(:one), questions(:two)]
  end
end
