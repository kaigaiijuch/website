# frozen_string_literal: true

class ApplicationYamlRecord < ActiveYaml::Base
  set_root_path Rails.application.config.x.yaml_base_directory
end
