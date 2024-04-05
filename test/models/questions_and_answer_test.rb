# frozen_string_literal: true

# == Schema Information
#
# Table name: questions_and_answers
#
#  id                         :integer
#  about                      :string
#  answered_on                :date
#  code                       :string
#  created_at:1               :datetime
#  display_order              :integer
#  display_order:1            :integer
#  name                       :string
#  number                     :string
#  question_number            :string
#  question_text              :text
#  text                       :text
#  text:1                     :text
#  topic_code                 :string
#  updated_at:1               :datetime
#  created_at                 :datetime
#  updated_at                 :datetime
#  guest_id                   :integer
#  guest_interview_profile_id :integer
#
require 'test_helper'

class QuestionAndAnswerTest < ActiveSupport::TestCase
  test 'questions_and_answer association of guest_interview_profiles should have correct relation and inverse' do
    assert_equal QuestionsAndAnswer.first.guest_interview_profile,
                 guest_interview_profiles(:one)
    assert_equal QuestionsAndAnswer.where(guest_interview_profile: guest_interview_profiles(:one)).all,
                 guest_interview_profiles(:one).questions_and_answers
  end

  test 'questions_and_answer association of guests should have correct relation and inverse' do
    assert_equal QuestionsAndAnswer.first.guest,
                 guests(:one)
    assert_equal QuestionsAndAnswer.where(guest: guests(:three)).all,
                 guests(:three).questions_and_answers
  end

  test 'questions_and_answer should be sorted default by topic_code and display_orde of qustions' do
    assert_equal [
      QuestionsAndAnswer.find(answers(:guest1_one_one).id),
      QuestionsAndAnswer.find(answers(:guest1_one_two).id),
      QuestionsAndAnswer.find(answers(:guest1_two_one).id)
    ], guest_interview_profiles(:one).questions_and_answers.all
  end
end
