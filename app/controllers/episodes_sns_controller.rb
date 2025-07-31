# frozen_string_literal: true

class EpisodesSnsController < ApplicationController
  def index
    @episodes = PublishedEpisode.order(published_at: :desc).all
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
