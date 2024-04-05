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
class QuestionsAndAnswer < ApplicationRecord
  belongs_to :guest_interview_profile
  belongs_to :guest

  def readonly?
    true
  end
end
