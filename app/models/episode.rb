# frozen_string_literal: true

class Episode < YamlRecord::Base
  data_file 'data/episodes.yml'
  attr_reader :number, :title, :url, :pub_date, :image_url, :description

  def initialize(**attributes) # rubocop:disable Lint/MissingSuper
    @number = attributes['title'].match(/#(\S+)/)[1]
    @title = attributes['title']
    @url = URI.parse(attributes['url'])
    @image_url = URI.parse(attributes['image_url'])
    @pub_date = Time.zone.parse(attributes['pub_date'])
    @description = attributes['description']
  end
end
