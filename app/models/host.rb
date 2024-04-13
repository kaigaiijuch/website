# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id           :integer          not null, primary key
#  english_name :string           not null
#  name         :string           not null
#  nickname     :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_hosts_on_nickname  (nickname) UNIQUE
#
class Host < ApplicationRecord
end
