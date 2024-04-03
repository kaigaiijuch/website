# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_references
#
#  id             :integer          not null, primary key
#  caption        :text             not null
#  display_order  :integer          default(1), not null
#  episode_number :string           not null
#  link           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_episode_references_on_episode_number_and_display_order  (episode_number,display_order) UNIQUE
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
require 'test_helper'

class EpisodeReferenceTest < ActiveSupport::TestCase
  setup do
    @episode = Episode.create(number: 'E1')
    @episode_reference = EpisodeReference.new(caption: 'Test Caption', episode_number: @episode.number, link: 'https://test.link')
  end

  test 'episode reference should have a caption' do
    @episode_reference.caption = ''
    assert_not @episode_reference.valid?
  end

  test 'episode reference should have an episode number' do
    @episode_reference.episode_number = ''
    assert_not @episode_reference.valid?
  end

  test 'episode reference should have a link' do
    @episode_reference.link = ''
    assert_not @episode_reference.valid?
  end

  test 'episode reference should have a valid episode' do
    assert_equal episode_references(:one).episode, episodes(:two)
    assert_equal episodes(:two).references, [episode_references(:one), episode_references(:two)]
  end
end
