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
  { code: 'life', name: '移住全般', display_order: 1 },
  { code: 'work', name: '仕事', display_order: 2 },
  { code: 'kids', name: '子育て', display_order: 3 }
].each do |topic_attrs|
  Topic.find_or_create_by!(topic_attrs)
end

%w[host co-host guest guest2].each do |type_name|
  EpisodeSpeakerRole.find_or_create_by!(name: type_name)
end
