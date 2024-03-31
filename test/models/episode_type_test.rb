# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
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
    episode_types = EpisodeType.order(:id).all

    assert_equal %w[full trailer bonus], episode_types.map(&:name)
  end

  test 'it cannot create duplicate name' do
    assert_raises(ActiveRecord::RecordNotUnique) { EpisodeType.create(name: 'full') }
  end
end
