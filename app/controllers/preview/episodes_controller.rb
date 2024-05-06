# frozen_string_literal: true

module Preview
  class EpisodesController < ApplicationController
    before_action :check_availability
    before_action :set_episode, only: %i[show]

    def index
      @episodes = UnpublishedEpisode.all.map { |e| e.extend(PreviewEpisode) }
    end

    def show; end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = UnpublishedEpisode.includes(guest_interview_profiles: [:questions_and_answers])
                                   .find(params[:id])
                                   .extend(PreviewEpisode)
    end

    def check_availability
      return if Rails.application.config.x.enable_preview

      flash.now[:alert] = t('error.forbidden')
      render status: :forbidden and return
    end

    module PreviewEpisode
      def published_at
        Time.zone.now
      end

      def feed_spotify_for_podcasters
        ''
      end

      def url
        'https://example.com/'
      end
    end
  end
end
