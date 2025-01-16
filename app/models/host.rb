# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  role_name   :string           not null
#  title       :string           not null
#  url         :string
#
# Foreign Keys
#
#  role_name  (role_name => host_roles.name)
#
class Host < ApplicationRecord
  belongs_to :role, class_name: 'HostRole', foreign_key: :role_name, primary_key: :name,
                    inverse_of: :hosts
end
