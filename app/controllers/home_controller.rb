# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @episodes = Episode.all
  end
end
