# frozen_string_literal: true

Rails.application.routes.url_helpers.tap do |h|
  puts h.root_path + 'index'
  puts h.feedback_path
  puts h.new_feedback_path
end
