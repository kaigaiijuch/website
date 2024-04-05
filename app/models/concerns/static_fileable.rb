# frozen_string_literal: true

module StaticFileable
  extend ActiveSupport::Concern

  def initialize(data)
    @data = data

    @data.each_key do |key|
      self.class.define_method(key) do
        @data.fetch(key)
      end
    end
  end

  def episode_number
    @data[:episode_number]
  end

  def episode
    @episode ||= Episode.find_by(number: episode_number)
  end

  def ==(other)
    @data.each_key do |key|
      return false if @data.fetch(key) != other.public_send(key)
    end
    true
  end

  class_methods do
    def static_file_name(lambda)
      @static_file_name = lambda
    end

    def file_column_separator(col_sep)
      @col_sep = col_sep
    end

    def headers(*headers)
      @headers = headers
    end

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

      CSV.read(file_path, col_sep: @col_sep, headers: @headers.presence || true)
         .map { |row| row.to_h.symbolize_keys.merge(episode_number: @episode_number) }
         .inject([]) { |result, data| result << EpisodeChapter.new(data) }
         .sort_by(&:time)
    end

    private

    def file_path
      Pathname(BASE_PATH + @static_file_name.call)
    end
  end
end
