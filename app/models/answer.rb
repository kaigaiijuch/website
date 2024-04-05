# frozen_string_literal: true

# == Schema Information
#
# Table name: answers
#
#  id                         :integer          not null, primary key
#  answered_on                :date             not null
#  question_number            :string           not null
#  question_text              :text             not null
#  text                       :text             not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  guest_id                   :integer          not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  index_answers_on_guest_id                    (guest_id)
#  index_answers_on_guest_interview_profile_id  (guest_interview_profile_id)
#  index_answers_on_question_number             (question_number)
#
# Foreign Keys
#
#  guest_id                    (guest_id => guests.id)
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#  question_number             (question_number => questions.number)
#
class Answer < ApplicationRecord
  belongs_to :guest_interview_profile
  belongs_to :guest
  belongs_to :question, foreign_key: :question_number, primary_key: :number, inverse_of: :answers
end
