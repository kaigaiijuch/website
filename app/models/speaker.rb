# frozen_string_literal: true

# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  image_path :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  global_id  :string           not null
#
class Speaker < ApplicationRecord
  ALLOWED_WHO_TYPE = [Host, Guest].freeze
  validates_each :who do |record, attr, value|
    record.errors.add attr, 'it allows only Host or Guest' if ALLOWED_WHO_TYPE.map { |type| value.is_a?(type) }.none?
  end

  def who
    @who ||= ::GlobalID::Locator.locate global_id
  end

  def who=(who)
    self.global_id = who.to_global_id.to_s
    @who = who
  end
end
