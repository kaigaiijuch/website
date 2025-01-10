# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  title       :string           not null
#  url         :string
#
require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 1, Host.count

    assert_equal '所 親宏', hosts.first.name
  end
end
