# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = Rails.application.config.x.website_uri.to_s

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add(episodes_path, priority: 1.0, lastmod: nil, changefreq: 'weekly')
  PublishedEpisode.find_each do |episode|
    add episode_path(episode), lastmod: nil, priority: 1.0, changefreq: 'weekly'
  end
end
