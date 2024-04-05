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

%w[full trailer bonus].each do |type_name|
  EpisodeType.find_or_create_by!(name: type_name)
end

[
  { code: 'life', name: '生活' },
  { code: 'work', name: '仕事' },
  { code: 'kids', name: '子育て' }
].each do |topic_attrs|
  Topic.find_or_create_by!(topic_attrs)
end
