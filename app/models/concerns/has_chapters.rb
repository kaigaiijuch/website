# frozen_string_literal: true

module HasChapters
  extend ActiveSupport::Concern

  included do
    has_many :chapters, class_name: 'EpisodeChapter', foreign_key: :episode_number, primary_key: :number,
                        inverse_of: :episode
  end
end
