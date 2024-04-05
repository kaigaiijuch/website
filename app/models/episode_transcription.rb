# frozen_string_literal: true

class EpisodeTranscription
  include StaticFileable
  static_file_name -> { "episodes/#{@episode_number}.transcription.csv" }
  headers true
end
