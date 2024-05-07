SELECT *
FROM episodes
LEFT OUTER JOIN feeds_spotify_for_podcasters ON feeds_spotify_for_podcasters.episode_number = episodes.number
WHERE feeds_spotify_for_podcasters.episode_number IS NULL
