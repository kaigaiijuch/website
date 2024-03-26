# frozen_string_literal: true

require 'test_helper'

class EpisodeDecoratorTest < ActiveSupport::TestCase
  def setup
    @episode = Episode.new.extend EpisodeDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
