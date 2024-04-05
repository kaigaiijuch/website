# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  code :string           not null, primary key
#  name :string           not null
#
require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = Topic.new(code: '001', name: 'Test Topic')
  end

  test 'code should be present' do
    @topic.code = nil

    assert_not @topic.valid?
    assert_raise ActiveRecord::NotNullViolation do
      @topic.save!(validate: false)
    end
  end

  test 'name should be present' do
    @topic.name = nil

    assert_not @topic.valid?
    assert_raise ActiveRecord::NotNullViolation do
      @topic.save!(validate: false)
    end
  end

  test 'code should be unique' do
    duplicate_topic = Topic.new(code: topics(:general).code, name: 'Duplicate Topic')

    assert_not duplicate_topic.valid?
    assert_raise ActiveRecord::RecordNotUnique do
      duplicate_topic.save!(validate: false)
    end
  end
end
