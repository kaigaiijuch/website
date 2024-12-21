# frozen_string_literal: true

class DropTimestamps < ActiveRecord::Migration[7.1]
  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def change
    remove_column :answers, :created_at, :datetime, null: false
    remove_column :answers, :updated_at, :datetime, null: false
    remove_column :episode_references, :created_at, :datetime, null: false
    remove_column :episode_references, :updated_at, :datetime, null: false
    remove_column :guest_interview_profiles, :created_at, :datetime, null: false
    remove_column :guest_interview_profiles, :updated_at, :datetime, null: false
    remove_column :episode_speakers, :created_at, :datetime, null: false
    remove_column :episode_speakers, :updated_at, :datetime, null: false
    remove_column :episode_speaker_transcriptions, :created_at, :datetime, null: false
    remove_column :episode_speaker_transcriptions, :updated_at, :datetime, null: false
    remove_column :feeds_spotify_for_podcasters, :created_at, :datetime, null: false
    remove_column :feeds_spotify_for_podcasters, :updated_at, :datetime, null: false
    remove_column :guest_interviews, :created_at, :datetime, null: false
    remove_column :guest_interviews, :updated_at, :datetime, null: false
    remove_column :guests, :created_at, :datetime, null: false
    remove_column :guests, :updated_at, :datetime, null: false
    remove_column :hosts, :created_at, :datetime, null: false
    remove_column :hosts, :updated_at, :datetime, null: false
    remove_column :questions, :created_at, :datetime, null: false
    remove_column :questions, :updated_at, :datetime, null: false
    remove_column :speakers, :created_at, :datetime, null: false
    remove_column :speakers, :updated_at, :datetime, null: false
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize
end
