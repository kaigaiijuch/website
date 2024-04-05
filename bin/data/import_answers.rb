#!/usr/bin/env ruby

require 'csv'

file_path = ARGV[0]
table_name = File.basename(file_path.split.last, '.csv')

puts "Importing to answers from #{file_path}"

csv = CSV.parse(File.read(file_path), headers: true)
QUESTION_NUMBER_REGEXP = /^#(?<number>.+):.*【.+】(?<text>.+)$/

## change headers to match the Answer model attributes
question_numbers = {}
csv.headers.each do |header|
  header.match(QUESTION_NUMBER_REGEXP)&.tap do |match|
    question_numbers[match[:number]] = match[:text]
    csv[match[:number]] = csv.delete(header)
  end
end

csv.each.with_index do |row, index|
  guest_id = row['guest_id']
  guest_interview_profile_id = row['guest_interview_profile_id']

  if guest_id.blank? || guest_interview_profile_id.blank?
    puts "Skiping(empty id) row index: #{index}"
    next
  end

  puts "Start importing row index: #{index}"

  question_numbers.each do |question_number, question_text|
    if row[question_number].blank?
      puts "  Skiping(empty text) number: #{question_number}, guest_id: #{guest_id}, guest_interview_profile_id: #{guest_interview_profile_id}"
      next
    end

    puts "  Importing number: #{question_number}, guest_id: #{guest_id}, guest_interview_profile_id: #{guest_interview_profile_id}"

    answer = Answer.find_or_initialize_by(question_number:, guest_id:,
                                          guest_interview_profile_id:)
    answer.original_question_text = question_text
    answer.answered_on = row['Timestamp']
    answer.guest_id = guest_id
    answer.guest_interview_profile_id = guest_interview_profile_id
    answer.text = row[question_number]
    answer.save!
  end
end
