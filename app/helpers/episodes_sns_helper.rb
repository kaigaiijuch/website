# frozen_string_literal: true

module EpisodesSnsHelper
  def guests_sns_mention(episode, target_sns)
    episode.guest_interview_profiles.flat_map(&target_sns).map(&:mention).join(' ')
  end

  def hashtags(_episode)
    "##{t('site.name')}" # TODO: extend to episode's original hashtags
  end

  def hosts_sns_mention(_episode, target_sns)
    # currently hard coded only for main host sns
    case target_sns
    when :sns_x
      '@kibitan'
    when :sns_bluesky, :sns_instagram
      '@chikahirotokoro'
    else
      ''
    end
  end
end
