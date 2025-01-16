# frozen_string_literal: true

# == Schema Information
#
# Table name: hosts
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  role_name   :string           not null
#  title       :string           not null
#  url         :string
#
# Foreign Keys
#
#  role_name  (role_name => host_roles.name)
#
require 'test_helper'

class HostTest < ActiveSupport::TestCase
  test 'should have correct attributes' do
    assert_equal 1, Host.count

    host = Host.find(hosts(:chikahiro).id)

    assert_equal hosts(:chikahiro).name, host.name
    assert_equal hosts(:chikahiro).description, host.description
    assert_equal hosts(:chikahiro).role_name, host.role_name
    assert_equal hosts(:chikahiro).title, host.title
    assert_equal hosts(:chikahiro).url, host.url

    assert_equal host_roles(:main).name, host.role.name
  end
end
