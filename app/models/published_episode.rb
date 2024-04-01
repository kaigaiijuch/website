# frozen_string_literal: true

class PublishedEpisode < ApplicationRecord
  def readonly?
    true
  end
end
