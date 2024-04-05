# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  code :string           not null, primary key
#  name :string           not null
#
class Topic < ApplicationRecord
  has_many :questions, foreign_key: :topic_code, primary_key: :code, inverse_of: :topic

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
