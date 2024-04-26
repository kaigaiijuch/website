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
  # implemntation note:
  #  there are other ways to implement for refer to Guest or Host
  #  1. STI (Single Table Inheritance) https://guides.rubyonrails.org/association_basics.html#single-table-inheritance-sti
  #    pros: rails standard way, guarantee to be only one host/guest
  #    cons: no foreign key constraint (no guarantee to be hosts/guests exists), database cannot represent the relation
  #          therefore sql become a bit complex.
  #  2. relation table (e.g. guest_speakers, host_speakers)
  #    pros: foreign key constrain (guarantee to be hosts/guests exists), database can represent the relation
  #    cons: no guarantee to be only one host/guest
  #  3. global_id (current implementation)
  #    its' a bit similar to STI, but can represent the relation in one database column.
  #  those are trade-offs, I choose as experimentabl to use GlobalID for now, i may change for the future.

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
