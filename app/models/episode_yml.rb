# frozen_string_literal: true

class EpisodeYml < ApplicationYamlRecord
  set_filename 'episodes'
  def number = key
  def id = key

  def image_url
    @image_url ||= URI.parse(@attributes[:image_url])
  end

  def url
    @url ||= URI.parse(@attributes[:url])
  end

  def pub_date
    @pub_date ||= Time.zone.parse(@attributes[:pub_date])
  end
end
