# frozen_string_literal: true

class CreateEpisodeTranscriptions < ActiveRecord::Migration[7.1]
  def change
    create_view :episode_transcriptions
  end
end
