# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @episodes = EpisodeYml.all
  end
end
