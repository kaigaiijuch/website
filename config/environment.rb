# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
    config.x.website_title.base = ENV["WEBSITE_TITLE_BASE"]
    config.x.website_title.separator = ENV["WEBSITE_TITLE_SEPARATOR"]
    config.x.google_tag_manager_id = ENV["GOOGLE_TAG_MANAGER_ID"]
end
