# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @episodes = PublishedEpisode.order(published_at: :desc).limit(3)
  end
end
