# frozen_string_literal: true

Rails.application.routes.url_helpers.tap do |h|
  puts h.home_path
  puts h.feedback_path
  puts h.new_feedback_path
  puts h.episodes_path
  puts h.episodes_path(format: :rss)
  puts h.episodes_sns_path(format: :rss)
  PublishedEpisode.find_each do |episode|
    puts h.episode_path(episode)
  end
  puts h.not_found_path
end
