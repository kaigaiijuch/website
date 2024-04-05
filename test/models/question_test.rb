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
    assert_equal questions(:one_one).topic, topics(:general)
    assert_equal topics(:general).questions.all, [questions(:one_one), questions(:one_two)]
  end

  test 'should default sorted by topic_code and display order accordingly' do
    assert_equal Question.all, [questions(:one_one), questions(:one_two), questions(:two_one)]
  end

  test 'should not duplicate the topic_code and display_order pair' do
    question = Question.new(topic_code: 'general', display_order: 1, text: 'New question', number: '1')

    assert_not question.valid?
    assert_raises(ActiveRecord::RecordNotUnique) { question.save!(validate: false) }
  end
end
