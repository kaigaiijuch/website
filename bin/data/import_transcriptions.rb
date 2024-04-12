#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'

file_path = ARGV[0]

csv = CSV.parse(File.read(file_path), headers: true)
episode_number = File.basename(file_path, '.transcription.csv')

puts "Importing to transcriptions from #{file_path}, episode_number: #{episode_number}"

csv.each do |row|
  puts "  Importing  #{row}"

  episode_speaker_transcription = EpisodeSpeakerTranscription.find_or_initialize_by(
    start_at: row['start_at'],
    episode_speaker_id: row['episode_speaker_id']
  )
  episode_speaker_transcription.end_at = row['end_at']
  episode_speaker_transcription.text = row['text']

  episode_speaker_transcription.save!
end
