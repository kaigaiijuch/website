# frozen_string_literal: true

class EpisodeChapter
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def time
    data[:time]
  end

  def title
    data[:title]
  end

  def episode_number
    data[:episode_number]
  end

  def episode
    @episode ||= Episode.find_by(number: episode_number)
  end

  def ==(other)
    time == other.time && title == other.title && episode_number == other.episode_number
  end

  class << self
    def where(episode_number:)
      Relation.new(episode_number:)
    end
  end

  class Relation
    require 'csv'
    BASE_PATH = Rails.application.config.x.static_file_root_directory

    def initialize(episode_number:)
      @episode_number = episode_number
    end

    def all
      return [] unless file_path.exist?

      CSV.read(file_path, col_sep: ' ', headers: %i[time title])
         .map { |row| row.to_h.merge(episode_number: @episode_number) }
         .inject([]) { |result, data| result << EpisodeChapter.new(data) }
         .sort_by(&:time)
    end

    private

    def file_path
      Pathname(BASE_PATH + "episodes/#{@episode_number}.chapters.txt")
    end
  end
end
