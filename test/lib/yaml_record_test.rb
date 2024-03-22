# frozen_string_literal: true

require 'test_helper'
require 'episodes_parser'

class EpisodesParserTest < ActiveSupport::TestCase
  test 'inherited YamlRecord::Base class can set data_file' do
    class Sample < YamlRecord::Base
      data_file 'test/fixtures/files/episodes.yml'
    end

    assert_equal 4, Sample.all.size
    sample = Sample.find('1-1')
    assert_equal '#1-1 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 前半 移住の経緯・現地企業での仕事環境の話', sample.title
  end
end
