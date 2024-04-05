# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  code          :string           not null, primary key
#  display_order :integer          not null
#  name          :string           not null
#
# Indexes
#
#  index_topics_on_display_order  (display_order) UNIQUE
#
require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  def setup
    @topic = Topic.new(code: '001', name: 'Test Topic', display_order: 4)
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
    duplicate_topic = Topic.new(code: topics(:life).code, name: 'Duplicate Topic', display_order: 5)

    assert_not duplicate_topic.valid?
    assert_raise ActiveRecord::RecordNotUnique do
      duplicate_topic.save!(validate: false)
    end
  end

  test 'should not duplicate the display_order' do
    topic = Topic.new(
      code: 'new',
      display_order: topics(:life).display_order,
      name: 'New topic'
    )

    assert_not topic.valid?
    assert_raises(ActiveRecord::RecordNotUnique) { topic.save!(validate: false) }
  end

  test 'the display_order should be positive value and greater than zero' do
    topic = Topic.new(
      code: 'new',
      display_order: 0,
      name: 'New topic'
    )

    assert_not topic.valid?
    assert_raises(ActiveRecord::StatementInvalid) do
      topic.save!(validate: false)
    end
  end
end
