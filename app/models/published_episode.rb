# frozen_string_literal: true

class PublishedEpisode < ApplicationRecord
  self.primary_key = 'number'

  def readonly?
    true
  end
end
