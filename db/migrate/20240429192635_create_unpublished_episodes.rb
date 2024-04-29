# frozen_string_literal: true

class CreateUnpublishedEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_view :unpublished_episodes
  end
end
