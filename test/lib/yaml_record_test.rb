# frozen_string_literal: true

require 'test_helper'
require 'episodes_parser'

module YamlRecord
  class BaseTest < ActiveSupport::TestCase
    class Sample < YamlRecord::Base
      data_file 'test/fixtures/files/episodes.yml'
    end
    test 'inherited YamlRecord::Base class can set data_file' do
      assert_equal 4, Sample.all.size
      assert_raise(NotImplementedError) do
        Sample.find('1-1')
      end
    end

    class Sample2 < YamlRecord::Base
      data_file 'test/fixtures/files/episodes.yml'
      attr_reader :title

      def initialize(**attributes) # rubocop:disable Lint/MissingSuper
        @title = attributes['title']
      end
    end
    test 'inherited YamlRecord::Base instance can access attributes' do
      assert_equal 4, Sample2.all.size
      sample = Sample2.find('0')
      assert_equal '#0 イントロダクション', sample.title
    end

    class NotFoundSample < YamlRecord::Base
      data_file 'not_exist.yml'
    end
    test 'inherited YamlRecord::Base class can but no file' do
      assert_raise(YamlRecord::Base::DataFileNotFound) do
        NotFoundSample.all
      end
    end
  end
end
