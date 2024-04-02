#!/usr/bin/env ruby
require "csv"

file_path = ARGV[0]
table_name = File.basename(file_path.split.last, '.csv')

puts "Importing to #{table_name} from #{file_path}"

csv = CSV.parse(File.read(file_path), headers: true)
model = table_name.singularize.capitalize.constantize

puts "Importing #{csv.count} records to #{model}"

csv.each do |row|
  model.find_or_initialize_by(model.primary_key => row.fetch(model.primary_key)).tap do |record|
    puts "Importing #{model} #{model.primary_key}: #{row.fetch(model.primary_key)}"
    record.attributes = row.to_h
    record.save!
  end
end
