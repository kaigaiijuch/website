# frozen_string_literal: true

module Descriptions
  class EpisodesController < ApplicationController
    def index
      @episodes = Episode.left_outer_joins(:feed_spotify_for_podcasters)
                         .includes(:feed_spotify_for_podcasters)
                         .order(published_at: :desc)
                         .all
    end

    def show; end
  end
end
