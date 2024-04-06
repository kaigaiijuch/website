# frozen_string_literal: true

# == Schema Information
#
# Table name: topics
#
#  code          :string           not null, primary key
#  display_order :integer          not null
#  name          :string           not null
#
# Indexes
#
#  index_topics_on_display_order  (display_order) UNIQUE
#
class Topic < ApplicationRecord
  has_many :questions, foreign_key: :topic_code, primary_key: :code, inverse_of: :topic

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true

  validates :display_order, presence: true, uniqueness: true,
                            numericality: { only_integer: true, greater_than: 0 }
end
