# frozen_string_literal: true

# == Schema Information
#
# Table name: questions
#
#  about         :string           not null
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
    assert_equal questions(:one_one).topic, topics(:life)
    assert_equal topics(:life).questions.all, [questions(:one_one), questions(:one_two)]
  end

  test 'should default sorted by topic_code and display order accordingly' do
    assert_equal Question.all, [questions(:one_one), questions(:one_two), questions(:two_one)]
  end

  test 'should not duplicate the topic_code and display_order pair' do
    question = Question.new(
      topic_code: 'life',
      display_order: 1,
      text: 'New question',
      number: '1',
      about: 'new'
    )

    assert_not question.valid?
    assert_raises(ActiveRecord::RecordNotUnique) { question.save!(validate: false) }
  end

  test 'the display_order should be positive value and greater than zero' do
    question = Question.new(
      number: '1',
      text: 'New question',
      display_order: 0,
      topic: topics(:life),
      about: 'new'
    )

    assert_not question.valid?
    assert_raises(ActiveRecord::StatementInvalid) do
      question.save!(validate: false)
    end
  end
end
