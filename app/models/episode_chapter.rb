# frozen_string_literal: true

class EpisodeChapter
  include StaticFileable
  static_file_name -> { "episodes/#{@episode_number}.chapters.txt" }
  file_column_separator ' '
  headers %i[time title]
end
