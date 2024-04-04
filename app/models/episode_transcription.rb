# frozen_string_literal: true

class EpisodeTranscription
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def episode
    @episode ||= Episode.find_by(number: episode_number)
  end

  def episode_number
    data.fetch(:episode_number)
  end

  def start_time
    data.fetch(:start_time)
  end

  def end_time
    data.fetch(:end_time)
  end

  def speaker
    data.fetch(:speaker)
  end

  def text
    data.fetch(:text)
  end

  def ==(other)
    data.each_key do |key|
      return false if data.fetch(key) != other.public_send(key)
    end
    true
  end

  class << self
    def where(episode_number:)
      Relation.new(episode_number:)
    end
  end

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
    end

    private

    def file_path
      Pathname(BASE_PATH + "episodes/#{@episode_number}.transcription.csv")
    end
  end
end