# frozen_string_literal: true

require 'test_helper'

class DescriptionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get descriptions_url
    assert_response :success
  end
end
