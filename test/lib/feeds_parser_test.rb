# frozen_string_literal: true

require 'test_helper'
require 'feeds_parser'

class FeedsParserTest < ActiveSupport::TestCase
  setup do
    @rss_feed = open('test/files/feed_spotify_for_podcasters.rss').read
  end

  test 'should fail parse' do
    assert_raises(FeedsParser::Feed::NoEpisodeNumber) do
      FeedsParser.from_podcast_rss_feed(
        source_url: 'https://example.com/rss',
        rss_feed: open('test/files/feed_spotify_for_podcasters_no_episode_title.rss').read
      )
    end
  end

  test 'should parse and return feeds' do
    feeds = FeedsParser.from_podcast_rss_feed(source_url: 'https://example.com/rss', rss_feed: @rss_feed)
    assert_equal 4, feeds.size

    feed = feeds.first
    assert_equal '2-1', feed.episode_number
    assert_equal '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話', feed.title
    assert_equal URI('https://podcasters.spotify.com/pod/show/kaigaiijuch/episodes/2-1-e2gujk0'), feed.url
    assert_equal URI('https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_episode/39369574/39369574-1710787766777-e18c234d0961e.jpg'),
                 feed.image_url
    assert_equal Time.new(2024, 3, 18, 21, 0, 0, '+00:00'), feed.published_at
    assert_equal ActiveSupport::TimeWithZone, feed.published_at.class
    assert_equal DESCRIPTION, feed.description
    assert_equal URI('https://anchor.fm/s/eb41ca58/podcast/play/83889216/https%3A%2F%2Fd3ctxlq1ktw2nl.cloudfront.net%2Fstaging%2F2024-2-18%2F2ced774b-d8ce-2216-983d-dcdd428c599b.mp3'),
                 feed.audio_file_url
    assert_equal 'メインホスト: 所 親宏', feed.creator
    assert_equal '00:39:39', feed.duration
    assert_equal false, feed.explicit
    assert_equal '2', feed.season_number
    assert_equal '1', feed.story_number
    assert_equal 'full', feed.episode_type
    assert_equal '77022728-edbe-4f05-976b-296736561661', feed.guid
    assert_equal 'https://example.com/rss', feed.source_url
  end

  test '#to_h should convert to hash' do
    feed = FeedsParser.from_podcast_rss_feed(source_url: 'https://example.com/rss', rss_feed: @rss_feed).first
    expected_hash = {
      episode_number: '2-1',
      title: '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話',
      url: URI('https://podcasters.spotify.com/pod/show/kaigaiijuch/episodes/2-1-e2gujk0'),
      image_url: URI('https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_episode/39369574/39369574-1710787766777-e18c234d0961e.jpg'),
      published_at: Time.new(2024, 3, 18, 21, 0, 0, '+00:00'),
      description: DESCRIPTION,
      audio_file_url: URI('https://anchor.fm/s/eb41ca58/podcast/play/83889216/https%3A%2F%2Fd3ctxlq1ktw2nl.cloudfront.net%2Fstaging%2F2024-2-18%2F2ced774b-d8ce-2216-983d-dcdd428c599b.mp3'),
      creator: 'メインホスト: 所 親宏',
      duration: '00:39:39',
      explicit: false,
      season_number: '2',
      story_number: '1',
      episode_type: 'full',
      guid: '77022728-edbe-4f05-976b-296736561661',
      source_url: 'https://example.com/rss'
    }

    assert_equal expected_hash, feed.to_h
  end

  DESCRIPTION = <<~DESCRIPTION
    <p>ゲスト: アメリカ・ロサンゼルス/ニューヨーク 8年 ドイツ・ベルリン在住 8年目 映像ディレクター 細井 洋介さん
    自己紹介:
    ベルリン在住映像ディレクター
    <a href="http://yosukehosoi.com/" target="_blank" rel="noopener noreferer">http://yosukehosoi.com/</a> <br />
    <a href="https://www.instagram.com/yosuke_eddie_hosoi/" target="_blank" rel="noopener noreferer">https://www.instagram.com/yosuke_eddie_hosoi/</a>

    国際パラリンピック委員会とWOWOWによるパラリンピック・ドキュメンタリー「WHO I AM 」演出作品で国際エミー賞ノミネートやミラノ国際スポーツ映像祭にて優秀賞を受賞。
    俳優としてはジョニーデップ主演映画「Minamata」に出演し、ベルリン国際映画祭に招待された。また通訳として、キアヌリーブス主演映画「John Wick 4」に参加。

    概要:
    2人目のゲスト、ベルリン在住の映像ディレクターで俳優の細井洋介さんが参加してくれました。映画監督やカメラマンとして活躍しながら、アメリカやヨーロッパでのキャリアを築いてきた経験を共有しています。高校卒業後から映画の世界に興味を持ち、アメリカで俳優学校に通った経験もあります。映画の勉強を続け、夢である映画監督としてのキャリアを築いていく中で、アメリカに戻ることができなくなった経験を振り返ります。この出来事が彼の人生に大きな影響を与え、再び将来を見つめ直す機会となりました。新たな方向性を模索し、日本に戻ってからは旅番組やドキュメンタリー制作など、映像制作と旅を組み合わせた仕事に挑戦。
    洋介さんの経験は、挫折や困難に直面しながらも、自分を見つめ直し新たな一歩を踏み出す姿勢に勇気をもらうとともに、海外での生活や仕事を考える上での貴重な示唆を提供してくれます。
    日本で新たなプロデューサーや映像制作者との出会いを経てコンテンツを制作し始め、世界中を旅する楽しさを発見し、またある感動のシーンの撮影で初めて涙が出た経験を振り返ります。
    ディレクターとして、様々な国のアスリートを追うドキュメンタリー制作に携わり、世界中で多くの人々に出会い、交流することの喜びを語ります。人とのつながりやコミュニケーションの重要性、相手との関係性の構築を築くことが重要視されます。
    映像作家としてのアプローチや、社会的な問題や力強いメッセージを映像を通じて伝えることへの情熱が語られます。ベルリンでの生活環境や異文化交流が創作活動やアイデアにどう影響を与えるかについても触れられ、独自の映像作品を通じて社会的な課題に焦点を当てる制作姿勢が示されます。次回は、ベルリンでの生活面についても触れていきたいと思います。

    </p>
    <p>
    リファレンス </p>
    <ul>
     <li>⁠<a href="https://corporate.wowow.co.jp/whoiam/" target="_blank">WHO I AM | 株式会社WOWOW</a></li>
     <li>⁠<a href="https://www.youtube.com/playlist?list=PLaBzzOA-v6UlZO2ZMxfSzUb7urG6YSdoP" target="_blank">WOWOW WHO I AM PROJECT</a></li>
    </ul>
    <p><br></p>
    <p>
    0:01:42 海外移住の動機
    0:03:11 アメリカの大学にて映画の勉強
    0:06:16 ビザ取得の失敗
    0:07:21 ビザの問題
    0:10:51 新たな方向性
    0:12:36 未来への展望
    0:14:45 旅番組制作の始まり
    0:17:05 映像制作者の多様性
    0:18:38 映像の力
    0:22:18 感動の瞬間
    0:23:50 ドキュメンタリーシリーズ
    0:29:37 ビジュアルの世界
    0:31:13 映画祭の舞台
    0:34:37 社会的な問題
    0:38:09 日本食への愛
    0:38:26 仕事と生活
    </p>
    <p>web site: ⁠⁠<a href="https://kaigaiiju.ch/" target="_blank" rel="noopener noreferer">海外移住channel</a> ⁠⁠
    フィードバックは<a href="⁠⁠https://kaigaiiju.ch/feedback" target="_blank" rel="noopener noreferer">こちら</a>から！ <a href="⁠⁠https://kaigaiiju.ch/feedback" target="_blank" rel="noopener noreferer">⁠⁠</a>⁠
    ホスト: ⁠⁠⁠所 親宏⁠⁠⁠ - ドイツ・ベルリン在住 ソフトウェアエンジニア <a href="https://chikahirotokoro.com/" target="_blank" rel="noopener noreferer">https://chikahirotokoro.com/</a></p> #2-1
  DESCRIPTION
end
