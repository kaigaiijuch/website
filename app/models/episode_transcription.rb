# frozen_string_literal: true

class EpisodeTranscription
  include StaticFileable

  class Relation
    require 'csv'
    BASE_PATH = Rails.root + Rails.application.config.x.static_file_root_directory

    def initialize(episode_number:)
      @episode_number = episode_number
    end

    def all
      return [] unless file_path.exist?

      CSV.read(file_path, headers: true)
         .map { |row| row.to_h.symbolize_keys.merge(episode_number: @episode_number) }
         .inject([]) { |result, data| result << EpisodeTranscription.new(data) }
         .sort_by(&:start_time)
    end

    private

    def file_path
      Pathname(BASE_PATH + "episodes/#{@episode_number}.transcription.csv")
    end
  end
  relation_class Relation
end
