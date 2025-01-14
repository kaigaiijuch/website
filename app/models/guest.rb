# frozen_string_literal: true

# == Schema Information
#
# Table name: guests
#
#  id           :integer          not null, primary key
#  english_name :string           not null
#  name         :string           not null
#  nickname     :string           not null
#
# Indexes
#
#  index_guests_on_nickname  (nickname) UNIQUE
#
class Guest < ApplicationRecord
  has_many :interview_profiles, class_name: 'GuestInterviewProfile', inverse_of: :guest
  has_many :answers, inverse_of: :guest, through: :interview_profiles
  has_many :questions_and_answers, inverse_of: :guest, through: :interview_profiles
end
