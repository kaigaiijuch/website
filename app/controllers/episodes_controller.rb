# frozen_string_literal: true

class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[show]
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_episode
    @episode = EpisodeYml.find_by(key: params[:id])
  end
end
