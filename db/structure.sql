CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "episode_types" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_episode_types_on_name" ON "episode_types" ("name");
CREATE TABLE IF NOT EXISTS "episodes" ("number" varchar NOT NULL PRIMARY KEY, "title" varchar(200) NOT NULL, "short_summary" text NOT NULL, "long_summary" text NOT NULL, "subtitle" text NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "type_id" integer NOT NULL, CONSTRAINT "fk_rails_3e4d157715"
FOREIGN KEY ("type_id")
  REFERENCES "episode_types" ("id")
);
CREATE UNIQUE INDEX "index_episodes_on_number" ON "episodes" ("number");
CREATE INDEX "index_episodes_on_type_id" ON "episodes" ("type_id");
INSERT INTO "schema_migrations" (version) VALUES
('20240331165930'),
('20240331101634');

