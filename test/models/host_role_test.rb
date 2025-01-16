# frozen_string_literal: true

# == Schema Information
#
# Table name: host_roles
#
#  name :string           not null
#
# Indexes
#
#  index_host_roles_on_name  (name) UNIQUE
#
require 'test_helper'

class HostRoleTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 2, HostRole.count

    assert_equal 'main', HostRole.find_by(name: 'main').name
    assert_equal 'regular', HostRole.find_by(name: 'regular').name
  end
end
