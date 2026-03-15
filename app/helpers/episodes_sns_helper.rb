# frozen_string_literal: true

module EpisodesSnsHelper
  def guests_sns_mention(episode, target_sns)
    episode.guest_interview_profiles.flat_map(&target_sns).map(&:mention).join(' ')
  end

  def hashtags(_episode)
    "##{t('site.name')}" # TODO: extend to episode's original hashtags
  end

  def hosts_sns_mention(episode, target_sns)
    # currently hard coded only for main host sns
    case target_sns
    when :sns_x
      '@kibitan'
    when :sns_instagram
      # TEMPORARY: remove the following suffix and temporary_mention_for_host? when no longer needed.
      '@chikahiro.tokoro' + (temporary_mention_for_host?(episode) ? ' @jirohari' : '')
    when :sns_bluesky
      '@chikahirotokoro.bsky.social'
    else
      ''
    end
  end

  private

  # TEMPORARY: Remove this method, TEMPORARY_HOST_MENTION_EPISODE_NUMBERS, and the extra ' @jirohari' in :sns_instagram branch when no longer needed.
  TEMPORARY_HOST_MENTION_EPISODE_NUMBERS = %w[a-7 31-1 31-2].freeze

  def temporary_mention_for_host?(episode)
    episode.present? && TEMPORARY_HOST_MENTION_EPISODE_NUMBERS.include?(episode.number)
  end
end
