# frozen_string_literal: true

require 'csv'

file_path = ARGV[0]
table_name = File.basename(file_path.split.last, '.csv')

puts "Importing to #{table_name} from #{file_path}"

csv = CSV.parse(File.read(file_path), headers: true)
model = table_name.singularize.camelize.constantize

puts "Importing #{csv.count} records to #{model}"

csv.each do |row|
  find_by_pair = model.primary_key.present? ? { model.primary_key => row.fetch(model.primary_key) } : row.to_h

  model.find_or_initialize_by(find_by_pair).tap do |record|
    puts "Importing #{model} #{find_by_pair}"
    record.attributes = row.to_h
    record.save!
  end
end
