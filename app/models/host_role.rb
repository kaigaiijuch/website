# frozen_string_literal: true

# == Schema Information
#
# Table name: host_roles
#
#  name :string           not null
#
# Indexes
#
#  index_host_roles_on_name  (name) UNIQUE
#
class HostRole < ApplicationRecord
  has_many :hosts, foreign_key: :name, inverse_of: :role
end
