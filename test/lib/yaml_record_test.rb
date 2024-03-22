# frozen_string_literal: true

require 'test_helper'
require 'episodes_parser'

class EpisodesParserTest < ActiveSupport::TestCase
  test 'inherited YamlRecord::Base class can set data_file' do
    class Sample < YamlRecord::Base
      data_file 'test/fixtures/files/episodes.yml'
    end

    assert_equal 4, Sample.all.size
    assert_raise(NotImplementedError) do
      Sample.find('1-1')
    end
  end
end
