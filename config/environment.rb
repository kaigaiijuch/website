# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

Rails.application.configure do
    config.google_tag_manager_id = ENV["GOOGLE_TAG_MANAGER_ID"]
end
