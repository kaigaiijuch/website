# frozen_string_literal: true

module HasGuestInterviews
  extend ActiveSupport::Concern

  included do
    has_many :guest_interviews, foreign_key: :episode_number, primary_key: :number, inverse_of: :episode
    has_many :guest_interview_profiles, through: :guest_interviews
    has_many :guests, through: :guest_interviews
  end
end
