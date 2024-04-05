# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  code :string           not null, primary key
#  name :string           not null
#
class Topic < ApplicationRecord
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
