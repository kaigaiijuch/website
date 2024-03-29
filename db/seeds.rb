# frozen_string_literal: true

# This file should ensure the existence of recorlication in every environment (production,
# development, test). The code here should be id executed at any point in every environment.
# The data can then be loaded with the bin/railsed alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
