# frozen_string_literal: true

module HasReferences
  extend ActiveSupport::Concern

  included do
    has_many :references, class_name: 'EpisodeReference', foreign_key: :episode_number, primary_key: :number,
                          inverse_of: :episode
  end
end
