# frozen_string_literal: true

class Episode < ActiveYaml::Base
  set_root_path 'data'
  set_filename 'episodes'

  def image_url
    URI.parse(@attributes[:image_url])
  end

  def url
    URI.parse(@attributes[:url])
  end

  def pub_date
    Time.zone.parse(@attributes[:pub_date])
  end
end
