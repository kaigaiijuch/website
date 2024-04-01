# frozen_string_literal: true

# == Schema Information
#
# Table name: guests
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
#  index_guests_on_nickname  (nickname) UNIQUE
#
require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 3, Guest.count

    guests = Guest.order(:nickname)
    assert_equal '所 親宏', guests.first.name
    assert_equal 'Kazunari Okuda', guests.second.english_name
  end
end
