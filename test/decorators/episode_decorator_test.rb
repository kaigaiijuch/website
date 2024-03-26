# frozen_string_literal: true

require 'test_helper'

class EpisodeDecoratorTest < ActiveSupport::TestCase
  setup do
    @episode = Episode.find_by(key: '1-1').extend EpisodeDecorator
  end

  test 'pub_date_s will return the formatted date' do
    assert '2024.3.5', @episode.pub_date_s
  end
end
