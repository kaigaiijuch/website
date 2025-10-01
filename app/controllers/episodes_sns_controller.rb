# frozen_string_literal: true

class EpisodesSnsController < ApplicationController
  def index # rubocop:disable Metrics/MethodLength
    @episodes = PublishedEpisode.order(published_at: :desc)
                                .includes(
                                  :references,
                                  guest_interview_profiles: %i[
                                    sns_instagram
                                    sns_x
                                    sns_bluesky
                                  ]
                                )
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
