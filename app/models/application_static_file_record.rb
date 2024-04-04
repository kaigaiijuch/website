# frozen_string_literal: true

class ApplicationStaticFileRecord < ActiveFile::Base
  require 'csv'
  set_root_path Rails.application.config.x.static_file_root_directory
  include ActiveHash::Associations
end
