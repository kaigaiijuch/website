# frozen_string_literal: true

# == Schema Information
#
# Table name: questions_and_answers_for_lives
#
#  id                         :integer
#  about                      :string
#  answered_on                :date
#  code                       :string
#  created_at:1               :datetime
#  display_order              :integer
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

class QuestionsAndAnswersForLifeTest < ActiveSupport::TestCase
  test 'question_and_answers_for_life association of guest_interview_profiles should have correct relation and inverse' do # rubocop:disable Metrics/LineLength
    assert_equal QuestionsAndAnswersForLife.first.guest_interview_profile,
                 guest_interview_profiles(:one)
    assert_equal QuestionsAndAnswersForLife.where(guest_interview_profile: guest_interview_profiles(:three)).all,
                 guest_interview_profiles(:three).questions_and_answers_for_lives
  end

  test 'question_and_answers_for_life association of guests should have correct relation and inverse' do
    assert_equal QuestionsAndAnswersForLife.where(guest: guests(:three)).all,
                 guests(:three).questions_and_answers_for_lives
    assert_equal QuestionsAndAnswersForLife.first.guest,
                 guests(:one)
  end
end
