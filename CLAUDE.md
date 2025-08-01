# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Ruby on Rails application for generating a **static website** for podcasts. The application follows the unix philosophy for the deployment pipeline and functional programming principles for stateless operations. It's currently used for [https://kaigaiiju.ch](https://kaigaiiju.ch).

Key design principles:
- Minimal dependencies, using standard Ruby/Rails solutions
- Database modeling with Domain-Driven Design (DDD) perspective
- Experimental CQRS pattern (separate Write and Read operations)
- Static site generation - outputs HTML/assets that can be served by any web server

## Development Environment

### Setup Commands
```bash
# Initial setup (installs dependencies, sets up database, clones data repo if DATA_REPO env var is set)
bin/setup

# Start development server
bin/rails server
# Access at http://localhost:3000

# Docker alternative
docker-compose up
# Access at http://localhost:13000
```

### Testing and Quality
```bash
# Run tests and linter (default rake task)
bin/rake

# Individual commands
bin/rake test          # Run test suite
bin/rake rubocop       # Run linter
```

## Build and Deployment

### Static Site Generation
```bash
# Build complete static site
bin/build

# Clean generated files
bin/clean

# Generate sitemap
bin/rake sitemap:refresh
```

The build process:
1. Creates sitemap.xml
2. Precompiles assets
3. Generates static pages based on `bin/pages/list.rb`

### Deployment Trigger
Commits with message containing `release!` trigger the GitHub Actions build workflow:
```bash
git commit --allow-empty -m 'release!'
git push origin main
```

## Data Management

### Data Import Commands
```bash
# Fetch all data sources (RSS feeds, CSVs, transcriptions)
bin/data/fetch_all [rss_feed_url] [csv/directory] [answers.csv] [transcription/csv/directory]

# Commit data changes
bin/data/commit

# Import from various sources
bin/data/import_from_csv
bin/data/import_transcription_csv
bin/data/download_csvs_from_gsheet
```

### Data Sources
- **RSS feeds**: Spotify for Podcasters format supported
- **CSV files**: Google Sheets export compatible
- **Episode chapters**: Static files in `data/episodes/#{episode_number}.chapters.txt`
- **Transcriptions**: CSV format with episode-specific naming

## Architecture

### MVC Structure
- **Models**: Domain models with database views for CQRS (check `db/views/`)
- **Controllers**: Standard Rails controllers with namespaces for different content types
- **Views**: ERB templates with partials, includes RSS builders

### Key Models
- `Episode` with concerns: `HasChapters`, `HasGuestInterviews`, `HasPhoto`, `HasReferences`, `HasTranscriptions`
- `PublishedEpisode` and `UnpublishedEpisode` (database views)
- `Guest`, `GuestInterview`, `GuestInterviewProfile`
- `Speaker`, `EpisodeSpeaker`, `EpisodeTranscription`

### Route Structure
- `/` - Home page
- `/episodes` - Episode index and show pages
- `/episodes.rss` - RSS feed
- `/episodes_sns.rss` - Social media RSS feed
- `/descriptions/episodes` - Episode descriptions
- `/preview/episodes` - Preview functionality
- `/feedbacks/new` - Feedback form

### Database
- SQLite3 with Scenic gem for database views
- Comprehensive constraints and indexes
- ERD documentation available in `docs/erd.pdf`

## Key Files and Directories

### Configuration
- `config/routes.rb` - Route definitions
- `config/sitemap.rb` - Sitemap generation config
- `bin/pages/list.rb` - Static page generation list

### Build Scripts
- `bin/build` - Main build script
- `bin/clean` - Cleanup script
- `bin/pages/build` - Page generation
- `bin/pages/clean` - Page cleanup

### Data Processing
- `lib/feeds_parser.rb` - RSS feed parsing
- `lib/tasks/data.rake` - Data import tasks
- `app/models/feeds_spotify_for_podcaster.rb` - Spotify feed handling

## Development Notes

- Ruby version: Check `.ruby-version` file
- Environment variables: Use `.env.local` for local overrides
- Page additions require updates to both `bin/pages/list.rb` and `config/sitemap.rb`
- Database uses constraints effectively - check migration files for business rules
- Static content goes in `data/` directory structure