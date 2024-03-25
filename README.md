[![CI](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/ci.yml)
[![build](https://github.com/kaigaiijuch/website/actions/workflows/build.yml/badge.svg)](https://github.com/kaigaiijuch/website/actions/workflows/build.yml)

# Website

This is the application for generating static website of [https://kaigaiiju.ch](https://kaigaiiju.ch).

## requirement

 * Ruby version: check [.ruby_version](.ruby-version)

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

## development instructions

For adding new pages, be aware that it may needs to added for page list on [bin/pages/list.rb](bin/pages/list.rb) and site map on [config/sitemap.rb](config/sitemap.rb).

## Configuration

check `.env` file and satisfy the requirements, they are used in `config/application.rb`.

`TZ` is used for setting timezone.

## Database creation && Database initialization

not using database!

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

### Generate Episodes data from RSS

```bash
 $ bin/rake build:episodes_yml_from_rss[https://podcast.url/rss.xml]
```

the data is stored default in `data/episodes.yml`.

#### conventions of episode title

title should be formatted as `#123-a title` where `123-a` is the episode number, it can be alphanumeric.

