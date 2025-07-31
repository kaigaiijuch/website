# frozen_string_literal: true

module EpisodesSnsHelper
  def sns_mention(episode, target_sns)
    episode.guest_interview_profiles.flat_map(&target_sns).map(&:mention).join(' ')
  end

  def hashtags(_episode)
    '#海外移住channel' # TODO: extend to episode's original hashtags
  end
end
