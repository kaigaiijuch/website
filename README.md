# README

This is the application for generating website of [https://kaigaiiju.ch](https://kaigaiiju.ch).

## requirement

 * Ruby version: check .ruby_version

### System dependencies

sqlite3

## setup

### local

```bash
 $ bin/setup
 $ bin/rails s
 $ open http://localhost:3000 # caution it's not HTTPS
```

### docker

```bash
  $ docker-compose up
  $ open http://localhost:13000 # caution it's not HTTPS
```

## Configuration

check `.env` file and satisfy the requirements, they are used in `config/application.rb`.

## Database creation && Database initialization

not using yet

## How to run the test suite and linter

```bash
 $ bin/rake
```

## Services (job queues, cache servers, search engines, etc.)

(TBC)

## Deployment instructions

(TBD)

### Sitemap generation

```bash
 $ bin/rake sitemap:refresh
```

### Generate Episodes data from RSS

```bash
 $ bin/rake "build:episodes_yml_from_rss[https://podcast.url/rss.xml]"
```

the data is stored in `data/episodes.yml`.
