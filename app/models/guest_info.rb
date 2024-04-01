# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_infos
#
#  id                    :integer          not null, primary key
#  abroad_living_summary :string           not null
#  introduction          :text             not null
#  job_title             :string           not null
#  tagline               :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  guest_id              :integer          not null
#
# Indexes
#
#  index_guest_infos_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  guest_id  (guest_id => guests.id)
#
class GuestInfo < ApplicationRecord
  belongs_to :guest
end
