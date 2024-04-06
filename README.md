[![CI](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml)
[![build](https://github.com/kaigaiijuch/website/actions/workflows/build.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/build.yml)

# Website

This is the application for generating a static website for podcasts. it's currently used for [https://kaigaiiju.ch](https://kaigaiiju.ch).

### with github workflow

if the latest commit message contains [RELEASE_TRRIGER_MESSAGE](https://github.com/kaigaiijuch/website/settings/variables/actions/RELEASE_TRRIGER_MESSAGE) then it will trigger the release workflow to build the website via [kaigaiijuch/release](https://github.com/kaigaiijuch/release/actions)

```bash
 # e.g. with RELEASE_TRRIGER_MESSAGE=release!
 $ git commit --allow-empty -m 'release!'
 $ git push origin main
```

it will trigger a build and make a pull-request on [kaigaiijuch/kaigaiijuch.github.io](https://github.com/kaigaiijuch/kaigaiijuch.github.io/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc)

## requirement

 * Ruby version: check [.ruby_version](.ruby-version)

sqlite3

## setup

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
 $ bin/data/fetch_all https://podcast.url/rss.xml csv/directory
```

[Spotify for podcasters](https://podcasters.spotify.com/) RSS feed is supported, it fetches the feeds data the data is stored default in `FeedsSpotifyForPodcaster`.

**important convention**: the title should be formatted as `#123-a title` where `123-a` is the episode number, it can be alphanumeric.

Import data from csv files in the directory, it is compatible with google sheets exported csv format. (this is temporary solution)

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

## Design

 * Architecture: check [wiki page](https://github.com/kaigaiijuch/website/wiki)

### ERD

![ERD](docs/erd.pdf)

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
