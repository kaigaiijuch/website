# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @episodes = PublishedEpisode.all
  end
end
