# frozen_string_literal: true

# == Schema Information
#
# Table name: questions_and_answers
#
#  id                         :integer          primary key
#  about                      :string
#  answer_text                :text
#  answered_on                :date
#  code                       :string
#  created_at:1               :datetime
#  display_order              :integer
#  display_order:1            :integer
#  name                       :string
#  number                     :string
#  original_question_text     :text
#  question_number            :string
#  question_text              :text
#  text                       :text
#  text:1                     :text
#  topic_code                 :string
#  topic_name                 :string
#  updated_at:1               :datetime
#  created_at                 :datetime
#  updated_at                 :datetime
#  guest_id                   :integer
#  guest_interview_profile_id :integer
#
class QuestionsAndAnswer < ApplicationRecord
  self.primary_key = :id
  belongs_to :guest_interview_profile
  belongs_to :guest
  belongs_to :question, foreign_key: :question_number, primary_key: :number, inverse_of: :answers
  belongs_to :topic, foreign_key: :topic_code, primary_key: :code, inverse_of: :questions
  scope :by_topic, -> { group_by(&:topic_name) }

  def readonly?
    true
  end
end
