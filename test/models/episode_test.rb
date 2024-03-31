# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  long_summary  :text             not null
#  number        :string           not null, primary key
#  short_summary :text             not null
#  subtitle      :text             not null
#  title         :string(200)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type_id       :integer          not null
#
# Indexes
#
#  index_episodes_on_number   (number) UNIQUE
#  index_episodes_on_type_id  (type_id)
#
# Foreign Keys
#
#  type_id  (type_id => episode_types.id)
#
require 'test_helper'
require 'minitest/autorun'

class EpisodeTest < ActiveSupport::TestCase
  # rubocop:disable Layout/LineLength
  test 'episode can read all as flat Episode object' do
    assert_equal 2, Episode.count

    episode = Episode.find('0')
    assert_equal '#0 イントロダクション', episode.title
    assert_equal '0', episode.number
    assert_equal '海外移住channelの第0回エピソードでは、ちかひろが自己紹介し、ポッドキャストのコンセプトや3本柱を紹介。第1回ではベルリン在住のソフトウェアエンジニアをゲストに招き、興味深い話題が期待される。海外移住に興味がある人や経験者に価値ある情報。',
                 episode.subtitle
    assert_equal '海外移住チャンネルの第0回エピソードでは、チャンネルのイントロダクションとして、海外移住チャンネルの発起人でありメインホストのちかひろが自己紹介を行います。ポッドキャストのコンセプトや番組の3本柱についても紹介され、今後の展開に期待が高まります。第1回エピソードではベルリン在住のソフトウェアエンジニアをゲストに迎え、興味深い話題が期待されます。海外移住に興味がある方やすでに移住経験者にとって、貴重な情報が得られることでしょう。',
                 episode.short_summary
    assert_equal <<~LONG_SUMMARY, episode.long_summary
      海外移住チャンネルの第0回エピソードでは、チャンネルのイントロダクションとして、海外移住チャンネルの発起人でありメインホストのちかひろが自己紹介を行います。ちかひろは7年前に妻とともにドイツベルリンに移住し、現地のスタートアップでソフトエンジニアとして働いています。また、子育ても経験したちかひろは、現在2人の子供の父親として、育休を取得し復帰を検討しています。
      ポッドキャストのコンセプトは、海外移住経験者をゲストに招き、インタビューを通じて様々な話題を取り上げることです。海外移住に興味があるリスナーだけでなく、すでに海外に移住している方にも興味深い内容を提供したいと考えています。ちかひろは、海外生活の良い面だけでなく、困難な側面もリアルに伝えたいと述べています。
      番組の3本柱として、海外移住、仕事、子育ての話題を中心に取り上げる予定であり、ゲストの属性に合わせて柔軟にコンテンツを提供する考えです。リスナーからのフィードバックも重視し、リクエストに応じてさまざまな企画を検討しています。現在はウェブサイトの制作も進行中であり、配信スケジュールは月2から4回を目指し、火曜日の日本時間の朝に配信予定です。
      第1回エピソードでは、ベルリン在住のソフトウェアエンジニアをゲストに迎え、子育てや仕事についての経験談を聞いています。今後は映画監督やダンサー、研究者など、さまざまなバックグラウンドを持つゲストを招いて、リスナーに興味深いトークを届ける予定です。海外移住チャンネルをフォローして、フィードバックをお寄せいただければ幸いです。
    LONG_SUMMARY
    assert_equal episode.type_id, 1
    assert_equal episode.type, EpisodeType.find_by(name: 'full')

    episode = Episode.find('1-1')
    assert_equal '#1-1 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 前半 移住の経緯・現地企業での仕事環境の話', episode.title
    assert_equal '1-1', episode.number

    assert_equal Episode.all,
                 EpisodeType.find_by(name: 'full').episodes
  end
  # rubocop:enable Layout/LineLength
end
