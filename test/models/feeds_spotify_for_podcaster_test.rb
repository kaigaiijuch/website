# frozen_string_literal: true

# == Schema Information
#
# Table name: feeds_spotify_for_podcasters
#
#  audio_file_url :string           not null
#  creator        :string           not null
#  description    :text             not null
#  duration       :string           not null
#  episode_number :string           not null, primary key
#  episode_type   :string           not null
#  explicit       :boolean          not null
#  guid           :string           not null
#  image_url      :string           not null
#  published_at   :datetime         not null
#  season_number  :string
#  source_url     :string           not null
#  story_number   :string
#  title          :string           not null
#  url            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_feeds_spotify_for_podcasters_on_episode_number  (episode_number) UNIQUE
#  index_feeds_spotify_for_podcasters_on_published_at    (published_at)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
require 'test_helper'

class FeedsSpotifyForPodcasterTest < ActiveSupport::TestCase
  test 'should has right attrbutes' do # rubocop:disable Metrics/BlockLength
    assert_equal 2, FeedsSpotifyForPodcaster.count

    feed = FeedsSpotifyForPodcaster.find('0')
    assert_equal '#0 イントロダクション', feed.title
    assert_equal '0', feed.episode_number
    assert_equal <<~DESCRIPTION, feed.description
      海外移住channel 第0回エピソードでは、メインホスト所の自己紹介とpodcastのコンセプトを紹介しています。
      海外移住channelでは、海外移住経験者をゲストに迎えてインタビューを通じて話を聞くことを中心に据え、リアルで率直な話を通して、海外生活の様々な側面を届けることを目指しています。海外移住、仕事、子育てを軸に据え、ゲストの属性に応じて対応し、リスナーからのフィードバックを重要視しています。
      月２−４回、火曜日の日本時間の朝にエピソードを配信予定であり、様々なバックグラウンドを持つゲストとのトークを楽しみにしています。

      web site: ⁠<a href="https://kaigaiiju.ch/" target="_blank">海外移住channel ⁠</a>
      フィードバックはこちらから！ ⁠<a href="https://kaigaiiju.ch/feedback" target="_blank">https://kaigaiiju.ch/feedback</a>
      ホスト: ⁠⁠<a href="https://chikahirotokoro.com/" target="_blank">所 親宏</a>⁠⁠ - ドイツ・ベルリン在住 ソフトウェアエンジニア

      00:00:00 海外移住channel始動
      00:01:07 ポッドキャストのコンセプト
      00:02:36 ゲストやフィードバックについて
      00:03:59 配信開始と今後の展望
    DESCRIPTION
    assert_equal 'trailer', feed.episode_type
    assert_equal Time.new(2024, 3, 2, 8, 15, 18, '+00:00'), feed.published_at
    assert_equal 'JST', feed.published_at.zone
    assert_equal '00:04:53', feed.duration
    assert_equal false, feed.explicit
    assert_nil feed.story_number
    assert_nil feed.season_number
    assert_equal '596d26ee-c803-41fd-bc91-6e3828e851c5', feed.guid
    assert_equal 'https://anchor.fm/s/eb41ca58/podcast/rss', feed.source_url
    assert_equal 'メインホスト: 所 親宏', feed.creator
    assert_equal feed.episode, Episode.find('0')
  end

  test 'timezone should be saved in utc on database' do
    feed = feeds_spotify_for_podcasters(:one)
    feed.update!(published_at: Time.new(2024, 4, 1, 10, 0, 0, '+09:00'))
    assert_equal '2024-04-01 01:00:00',
                 feed.reload.read_attribute_before_type_cast(:published_at)
  end
end
