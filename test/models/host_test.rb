# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id           :integer          not null, primary key
#  english_name :string           not null
#  name         :string           not null
#  nickname     :string           not null
#
# Indexes
#
#  index_hosts_on_nickname  (nickname) UNIQUE
#
require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 1, Host.count

    assert_equal '所 親宏', hosts.first.name
  end
end
