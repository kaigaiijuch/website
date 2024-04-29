[![CI](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml)
[![build](https://github.com/kaigaiijuch/website/actions/workflows/build.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/build.yml)

# Website

This is the application for generating a **static website** for podcasts, which means output HTML/assets and can be served by just a web server. it is quite inspired by unix philosophy for deployment pipeline, and functional programming for stateless.
it's currently used for [https://kaigaiiju.ch](https://kaigaiiju.ch).

## Design Concept

 * dependencies as little as possible

Try to make fewer external libraries and use a more standard solution of Ruby/Rails which is a lot of maintenance. for instance, not necessary to use RSpec.

 * Try to follow Rails way architecture

more discussion can be found here [on wiki](https://github.com/kaigaiijuch/website/wiki)

 * Use Database modeling with a DDD perspective

use database constraints and modeling effectively, [ERD can be found here](docs/erd.pdf).

 * (experimental) CQRS

Write operation and Read Operation have different requirements, try not to mix it up.


## Deployment pipeline with Github Action

if the latest commit message contains [RELEASE_TRRIGER_MESSAGE](https://github.com/kaigaiijuch/website/settings/variables/actions/RELEASE_TRRIGER_MESSAGE) then it will trigger the release workflow to build the website via [kaigaiijuch/release](https://github.com/kaigaiijuch/release/actions).

```bash
 # e.g. with RELEASE_TRRIGER_MESSAGE=release!
 $ git commit --allow-empty -m 'release!'
 $ git push origin main
```

it will trigger a build and make a pull-request on [kaigaiijuch/kaigaiijuch.github.io](https://github.com/kaigaiijuch/kaigaiijuch.github.io/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc). the trigger defined at [here](.github/workflows/build.yml)

also there is [`fetch_rss` trigger scheduled](.github/workflows/fetch_rss.yml), it can trigger via curl. (you need token)
```bash
curl -L -X POST -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${GITHUB_TOKEN}" -H "X-GitHub-Api-Version: 2022-11-28" https://api.github.com/repos/kaigaiijuch/website/dispatches -d '{"event_type":"fetch_rss"}'
```

## development requirement

 * Ruby version: check [.ruby_version](.ruby-version)
 * sqlite3

### setup

### local

```bash
 $ bin/setup # with DATA_REPO=your_data_repo, it will clone the data repository
 $ bin/rails s
 $ open http://localhost:3000 # caution it's not HTTPS
```

### docker

```bash
  $ docker-compose up
  $ open http://localhost:13000 # caution it's not HTTPS
```

## Prepare data

### fetch

```bash
 $ bin/data/fetch_all [rss_feed_url] [csv/directory] [answers.csv] [transcription/csv/directory]
```

This is **idempotent** operation, it fetches the data from the sources and store it in the data repository.

* `rss_feed_url`: [Spotify for podcasters](https://podcasters.spotify.com/) RSS feed is supported, it fetches the feeds data the data is stored default in `FeedsSpotifyForPodcaster`.

  **important convention**: the description of the episode should be ended by formatted as `#123-a title` where `123-a` is the episode number, it can be alphanumeric.

* `csv/directory`: (this is a temporary solution) Import data from csv files in the directory, it is compatible with google sheets exported csv format, sample file: (TBD).

* `answers.csv`: (this is a temporary solution) Import answers from csv file, it is compatible with exported csv format of google forms linked spreadsheet. The format is `#{question_number}: 【{category}】{question_original_title}`, sample file: (TBD).

* `transcription/csv/directory`: (this is a temporary solution) Import transcriptions from csv file. The file name should be `#{episode_number}.transcription.csv`, sample file: (TBD).

### commit data

```bash
 $ bin/data/commit
```

this will commit the data to the data repository.

### static data

* `data/episodes/#{episode_number}.chapters.txt` - chapter data for the episode. the data format is `HH:MM:SS.mmm title`. sample file is [here](test/data/episodes/0.chapters.txt)


## development instructions

For adding new pages, be aware that it may needs to added for page list on [bin/pages/list.rb](bin/pages/list.rb) and site map on [config/sitemap.rb](config/sitemap.rb).

## Configuration

check `.env` file and satisfy the requirements, they are used in `config/application.rb`.

`TZ` is used for setting timezone.

## Database creation && Database initialization


```bash
  $ bin/rake db:create db:migrate db:seed
```

## How to run the test suite and linter

```bash
 $ bin/rake
```

## Deployment instructions

```bash
 $ bin/build
```

it will generate the static pages in `public/` directory based on the path list in `bin/pages/list.rb`.

NOTE: after generate in `public/` directory, the pages are served as static pages not by server. use `bin/clean` to remove static pages.

for github build workflow: it needs to set [DATA_REPO_TOKEN](.github/workflows/build.yml) as a secret.

### Sitemap generation

```bash
 $ bin/rake sitemap:refresh
```
