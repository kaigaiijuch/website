# frozen_string_literal: true

class EpisodeChapter < ApplicationStaticFileRecord
  set_filename 'episodes/0 introduction.chapters'
  belongs_to :episode, class_name: 'Episode', foreign_key: :episode_number, primary_key: :number, inverse_of: :chapters

  def episode_number
    '0'
  end

  class << self
    def extension
      'txt'
    end

    def load_file
      CSV.read(full_path, col_sep: ' ', headers: %i[time title]).map(&:to_h)
    end
  end
end
