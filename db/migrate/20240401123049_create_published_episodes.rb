# frozen_string_literal: true

class CreatePublishedEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_view :published_episodes
  end
end
