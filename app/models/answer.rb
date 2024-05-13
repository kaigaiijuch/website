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
class Answer < ApplicationRecord
  belongs_to :guest_interview_profile
  has_one :guest, through: :guest_interview_profile
  belongs_to :question, foreign_key: :question_number, primary_key: :number, inverse_of: :answers
end
