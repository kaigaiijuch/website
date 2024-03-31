CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE TABLE IF NOT EXISTS "episodes" ("number" varchar NOT NULL PRIMARY KEY, "title" varchar(200) NOT NULL, "short_summary" text NOT NULL, "long_summary" text NOT NULL, "subtitle" text NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_episodes_on_number" ON "episodes" ("number");
INSERT INTO "schema_migrations" (version) VALUES
('20240331101634');

