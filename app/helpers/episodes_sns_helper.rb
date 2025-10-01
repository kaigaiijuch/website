# frozen_string_literal: true

module EpisodesSnsHelper
  def guest_sns_mention(episode, target_sns)
    episode.guest_interview_profiles.flat_map(&target_sns).map(&:mention).join(' ')
  end

  def hashtags(_episode)
    "##{t('site.name')}" # TODO: extend to episode's original hashtags
  end
end
