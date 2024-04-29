# frozen_string_literal: true

module Preview
  class EpisodesController < ApplicationController
    before_action :set_episode, only: %i[show]
    def index
      @episodes = Episode.all.map { |e| e.extend(PreviewEpisode) }
    end

    def show; end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.includes(guest_interview_profiles: [:questions_and_answers]).find(params[:id])
                        .extend(PreviewEpisode)
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
