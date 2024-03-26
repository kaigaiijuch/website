# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @episodes = Episode.all.map { |episode| episode.extend(EpisodeDecorator) } # workaround
  end
end
