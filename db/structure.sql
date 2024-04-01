CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "episode_types" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_episode_types_on_name" ON "episode_types" ("name");
CREATE TABLE IF NOT EXISTS "feeds_spotify_for_podcasters" ("episode_number" varchar NOT NULL PRIMARY KEY, "source_url" varchar NOT NULL, "title" varchar NOT NULL, "url" varchar NOT NULL, "audio_file_url" varchar NOT NULL, "image_url" varchar NOT NULL, "published_at" datetime(6) NOT NULL, "description" text NOT NULL, "duration" varchar NOT NULL, "explicit" boolean NOT NULL, "season_number" varchar, "story_number" varchar, "episode_type" varchar NOT NULL, "guid" varchar NOT NULL, "creator" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_fac382d39c"
FOREIGN KEY ("episode_number")
  REFERENCES "episodes" ("number")
);
CREATE UNIQUE INDEX "index_feeds_spotify_for_podcasters_on_episode_number" ON "feeds_spotify_for_podcasters" ("episode_number");
CREATE INDEX "index_feeds_spotify_for_podcasters_on_published_at" ON "feeds_spotify_for_podcasters" ("published_at");
CREATE VIEW "published_episodes" AS SELECT
 *
FROM episodes
JOIN feeds_spotify_for_podcasters ON feeds_spotify_for_podcasters.episode_number = episodes.number
/* published_episodes(number,title,short_summary,long_summary,subtitle,created_at,updated_at,type_id,season_number,story_number,episode_number,source_url,"title:1",url,audio_file_url,image_url,published_at,description,duration,explicit,"season_number:1","story_number:1",episode_type,guid,creator,"created_at:1","updated_at:1") */;
CREATE TABLE IF NOT EXISTS "guests" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nickname" varchar NOT NULL, "name" varchar NOT NULL, "english_name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_guests_on_nickname" ON "guests" ("nickname");
CREATE TABLE IF NOT EXISTS "guest_infos" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "guest_id" integer NOT NULL, "tagline" varchar NOT NULL, "job_title" varchar NOT NULL, "introduction" text NOT NULL, "abroad_living_summary" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_633b51a24c"
FOREIGN KEY ("guest_id")
  REFERENCES "guests" ("id")
);
CREATE INDEX "index_guest_infos_on_guest_id" ON "guest_infos" ("guest_id");
CREATE TABLE IF NOT EXISTS "episodes" ("number" varchar NOT NULL PRIMARY KEY, "title" varchar(200) NOT NULL, "short_summary" text NOT NULL, "long_summary" text NOT NULL, "subtitle" text NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "type_id" integer NOT NULL, "season_number" integer, "story_number" integer, CONSTRAINT "fk_rails_3e4d157715"
FOREIGN KEY ("type_id")
  REFERENCES "episode_types" ("id")
);
CREATE UNIQUE INDEX "index_episodes_on_number" ON "episodes" ("number");
CREATE INDEX "index_episodes_on_type_id" ON "episodes" ("type_id");
CREATE UNIQUE INDEX "index_episodes_on_season_number_and_story_number" ON "episodes" ("season_number", "story_number");
CREATE TABLE IF NOT EXISTS "guest_interviews" ("episode_number" varchar NOT NULL, "guest_info_id" integer NOT NULL, CONSTRAINT "fk_rails_c2329fd873"
FOREIGN KEY ("guest_info_id")
  REFERENCES "guest_infos" ("id")
, CONSTRAINT "fk_rails_6e428d54d7"
FOREIGN KEY ("episode_number")
  REFERENCES "episodes" ("number")
);
CREATE INDEX "index_guest_interviews_on_guest_info_id" ON "guest_interviews" ("guest_info_id");
CREATE UNIQUE INDEX "index_guest_interviews_on_episode_number_and_guest_info_id" ON "guest_interviews" ("episode_number", "guest_info_id");
INSERT INTO "schema_migrations" (version) VALUES
('20240401154222'),
('20240401152744'),
('20240401140043'),
('20240401131711'),
('20240401123049'),
('20240331210116'),
('20240331165930'),
('20240331101634');

