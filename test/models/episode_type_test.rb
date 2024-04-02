# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_types
#
#  name       :string           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_episode_types_on_name  (name) UNIQUE
#
require 'test_helper'

class EpisodeTypeTest < ActiveSupport::TestCase
  test 'it has 3 types in the records' do
    assert_equal %w[bonus full trailer], EpisodeType.order(:name).pluck(:name)
  end

  test 'it cannot create duplicate name' do
    assert_raises(ActiveRecord::RecordNotUnique) { EpisodeType.create(name: 'full') }
  end
end
