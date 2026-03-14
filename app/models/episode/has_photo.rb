# frozen_string_literal: true

class Episode
  module HasPhoto
    extend ActiveSupport::Concern

    included do
      has_many :photos, class_name: 'EpisodePhoto', foreign_key: :episode_number, primary_key: :number,
                        inverse_of: :episode
    end
  end
end
