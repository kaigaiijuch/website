CREATE TABLE IF NOT EXISTS "episode_types" ("name" varchar NOT NULL PRIMARY KEY);
CREATE UNIQUE INDEX "index_episode_types_on_name" ON "episode_types" ("name");
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "guests" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "nickname" varchar NOT NULL, "name" varchar NOT NULL, "english_name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_guests_on_nickname" ON "guests" ("nickname");
CREATE TABLE IF NOT EXISTS "feeds_spotify_for_podcasters" ("episode_number" varchar NOT NULL PRIMARY KEY, "source_url" varchar NOT NULL, "title" varchar NOT NULL, "url" varchar NOT NULL, "audio_file_url" varchar NOT NULL, "image_url" varchar NOT NULL, "published_at" datetime(6) NOT NULL, "description" text NOT NULL, "duration" varchar NOT NULL, "explicit" boolean NOT NULL, "season_number" varchar DEFAULT NULL, "story_number" varchar DEFAULT NULL, "episode_type" varchar NOT NULL, "guid" varchar NOT NULL, "creator" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_fac382d39c"
FOREIGN KEY ("episode_number")
  REFERENCES "episodes" ("number")
);
CREATE UNIQUE INDEX "index_feeds_spotify_for_podcasters_on_episode_number" ON "feeds_spotify_for_podcasters" ("episode_number");
CREATE INDEX "index_feeds_spotify_for_podcasters_on_published_at" ON "feeds_spotify_for_podcasters" ("published_at");
CREATE VIEW "published_episodes" AS       SELECT
     *
    FROM episodes
    JOIN feeds_spotify_for_podcasters ON feeds_spotify_for_podcasters.episode_number = episodes.number
/* published_episodes(number,title,summary,long_summary,subtitle,created_at,updated_at,season_number,story_number,type_name,episode_number,source_url,"title:1",url,audio_file_url,image_url,published_at,description,duration,explicit,"season_number:1","story_number:1",episode_type,guid,creator,"created_at:1","updated_at:1") */;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "episode_references" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "episode_number" varchar NOT NULL, "link" varchar NOT NULL, "caption" text NOT NULL, "display_order" integer DEFAULT 1 NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_2f98112f52"
FOREIGN KEY ("episode_number")
  REFERENCES "episodes" ("number")
, CONSTRAINT chk_rails_f3946b04e3 CHECK (display_order > 0));
CREATE UNIQUE INDEX "index_episode_references_on_episode_number_and_display_order" ON "episode_references" ("episode_number", "display_order");
CREATE TABLE IF NOT EXISTS "episodes" ("number" varchar NOT NULL PRIMARY KEY, "title" varchar(200) NOT NULL, "summary" text NOT NULL, "long_summary" text NOT NULL, "subtitle" text NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "season_number" integer DEFAULT NULL, "story_number" integer DEFAULT NULL, "type_name" varchar NOT NULL, CONSTRAINT "fk_rails_eafa210e4e"
FOREIGN KEY ("type_name")
  REFERENCES "episode_types" ("name")
);
CREATE UNIQUE INDEX "index_episodes_on_number" ON "episodes" ("number");
CREATE UNIQUE INDEX "index_episodes_on_season_number_and_story_number" ON "episodes" ("season_number", "story_number");
CREATE TABLE IF NOT EXISTS "guest_interview_profiles" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "guest_id" integer NOT NULL, "tagline" varchar NOT NULL, "job_title" varchar NOT NULL, "introduction" text NOT NULL, "abroad_living_summary" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "guest_name" varchar NOT NULL, "image_path" varchar NOT NULL, "interviewed_on" date NOT NULL, CONSTRAINT "fk_rails_f9437323b7"
FOREIGN KEY ("guest_id")
  REFERENCES "guests" ("id")
);
CREATE INDEX "index_guest_interview_profiles_on_guest_id" ON "guest_interview_profiles" ("guest_id");
CREATE TABLE IF NOT EXISTS "guest_interviews" ("episode_number" varchar NOT NULL, "guest_interview_profile_id" integer NOT NULL, "display_order" integer DEFAULT 1 NOT NULL, "interviewed_on" date NOT NULL, CONSTRAINT "fk_rails_6e428d54d7"
FOREIGN KEY ("episode_number")
  REFERENCES "episodes" ("number")
, CONSTRAINT "fk_rails_8df479fb6d"
FOREIGN KEY ("guest_interview_profile_id")
  REFERENCES "guest_interview_profiles" ("id")
, CONSTRAINT check_display_order_positive CHECK (display_order > 0));
CREATE UNIQUE INDEX "idx_on_episode_number_guest_interview_profile_id_967e3dfe76" ON "guest_interviews" ("episode_number", "guest_interview_profile_id");
CREATE INDEX "index_guest_interviews_on_guest_interview_profile_id" ON "guest_interviews" ("guest_interview_profile_id");
CREATE UNIQUE INDEX "index_guest_interviews_on_episode_number_and_display_order" ON "guest_interviews" ("episode_number", "display_order");
CREATE TABLE IF NOT EXISTS "topics" ("code" varchar NOT NULL PRIMARY KEY, "name" varchar NOT NULL, "display_order" integer NOT NULL, CONSTRAINT chk_rails_00c1af1e31 CHECK (display_order > 0));
CREATE UNIQUE INDEX "index_topics_on_display_order" ON "topics" ("display_order");
CREATE TABLE IF NOT EXISTS "answers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "text" text NOT NULL, "answered_on" date NOT NULL, "question_number" varchar NOT NULL, "question_text" text NOT NULL, "guest_interview_profile_id" integer NOT NULL, "guest_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_f5c924b3a5"
FOREIGN KEY ("question_number")
  REFERENCES "questions" ("number")
, CONSTRAINT "fk_rails_068c6d77e9"
FOREIGN KEY ("guest_interview_profile_id")
  REFERENCES "guest_interview_profiles" ("id")
, CONSTRAINT "fk_rails_1d84a4a538"
FOREIGN KEY ("guest_id")
  REFERENCES "guests" ("id")
);
CREATE INDEX "index_answers_on_question_number" ON "answers" ("question_number");
CREATE INDEX "index_answers_on_guest_interview_profile_id" ON "answers" ("guest_interview_profile_id");
CREATE INDEX "index_answers_on_guest_id" ON "answers" ("guest_id");
CREATE TABLE IF NOT EXISTS "questions" ("number" varchar NOT NULL PRIMARY KEY, "text" text NOT NULL, "display_order" integer NOT NULL, "topic_code" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "about" varchar NOT NULL, CONSTRAINT "fk_rails_251e626c71"
FOREIGN KEY ("topic_code")
  REFERENCES "topics" ("code")
, CONSTRAINT chk_rails_3b193a7e50 CHECK (display_order > 0));
CREATE UNIQUE INDEX "index_questions_on_topic_code_and_display_order" ON "questions" ("topic_code", "display_order");
CREATE VIEW "questions_and_answers" AS SELECT *, answers.text AS answer_text, topics.name AS topic_name
FROM answers
JOIN questions ON answers.question_number = questions.number
JOIN topics ON questions.topic_code = topics.code
ORDER BY topics.display_order ASC, questions.display_order ASC
/* questions_and_answers(id,text,answered_on,question_number,question_text,guest_interview_profile_id,guest_id,created_at,updated_at,number,"text:1",display_order,topic_code,"created_at:1","updated_at:1",about,code,name,"display_order:1",answer_text,topic_name) */;
INSERT INTO "schema_migrations" (version) VALUES
('20240405145217'),
('20240405140159'),
('20240405131030'),
('20240405121007'),
('20240405112025'),
('20240405111039'),
('20240405105326'),
('20240403155225'),
('20240403102446'),
('20240403095620'),
('20240403090919'),
('20240403090050'),
('20240402082719'),
('20240402082545'),
('20240402074804'),
('20240401201847'),
('20240401183433'),
('20240401154222'),
('20240401152744'),
('20240401140043'),
('20240401131711'),
('20240401123049'),
('20240331210116'),
('20240331165930'),
('20240331101634');

