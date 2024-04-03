# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[show]
  def index; end
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_episode
    @episode = PublishedEpisode.find(params[:id])
  end
end
