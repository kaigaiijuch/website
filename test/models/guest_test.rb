# frozen_string_literal: true

# == Schema Information
#
# Table name: guests
#
#  id           :integer          not null, primary key
#  english_name :string           not null
#  name         :string           not null
#
require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 4, Guest.count

    assert_equal '奥田 一成', guests(:one).name
    assert_equal 'Kazunari Okuda', guests(:one).english_name
    assert_equal '所 親宏', guests(:three).name
  end
end
