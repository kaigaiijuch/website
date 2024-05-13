# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id                         :integer          not null, primary key
#  answered_on                :date             not null
#  original_question_text     :text             not null
#  question_number            :string           not null
#  text                       :text             not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  idx_on_guest_interview_profile_id_question_number_2d039c51c9  (guest_interview_profile_id,question_number) UNIQUE
#  index_answers_on_question_number                              (question_number)
#
# Foreign Keys
#
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#  question_number             (question_number => questions.number)
#
require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # Append to /Users/kibitan/repo/github.com/kaigaiijuch/website/test/models/guest_interview_profile_test.rb

  test 'answers association of guests should have correct relation and inverse' do
    assert_equal guests(:three), answers(:guest3_one_one).guest
    assert_equal [answers(:guest3_one_one)], guests(:three).answers.all
  end

  test 'answers association of questions should have correct relation and inverse' do
    assert_equal questions(:two_one), answers(:guest1_two_one).question
    assert_equal [answers(:guest1_one_two)], questions(:one_two).answers
  end

  test 'answers association of guest_interview_profiles should have correct relation and inverse' do
    assert_equal guest_interview_profiles(:three), answers(:guest3_one_one).guest_interview_profile
    assert_equal [answers(:guest3_one_one)], guest_interview_profiles(:three).answers.all
  end
end
