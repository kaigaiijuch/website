# frozen_string_literal: true

class Episode
  module HasTranscriptions
    extend ActiveSupport::Concern

    included do
      has_many :transcriptions, class_name: 'EpisodeTranscription', foreign_key: :episode_number, primary_key: :number,
                                inverse_of: :episode
    end
  end
end
