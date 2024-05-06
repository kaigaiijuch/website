# frozen_string_literal: true

module Preview
  class EpisodesController < ApplicationController
    before_action :check_availability
    before_action :set_episode, only: %i[show]

    def index
      @episodes = UnpublishedEpisode.all
    end

    def show; end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = UnpublishedEpisode.includes(guest_interview_profiles: [:questions_and_answers])
                                   .find(params[:id])
    end

    def check_availability
      return if Rails.application.config.x.enable_preview

      flash.now[:alert] = t('error.forbidden')
      render status: :forbidden and return
    end
  end
end
