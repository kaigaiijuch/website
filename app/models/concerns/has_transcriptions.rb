# frozen_string_literal: true

module HasTranscriptions
  extend ActiveSupport::Concern

  def transcriptions
    @transcriptions ||= EpisodeTranscription.where(episode_number: number).all
  end
end
