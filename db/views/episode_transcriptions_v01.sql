SELECT *
FROM episode_speaker_transcriptions
INNER JOIN episode_speakers ON episode_speaker_transcriptions.episode_speaker_id = episode_speakers.id
INNER JOIN speakers ON episode_speakers.speaker_id = speakers.id
ORDER BY episode_number, start_at
