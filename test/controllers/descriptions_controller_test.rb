# frozen_string_literal: true

require 'test_helper'

class DescriptionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get descriptions_path
    assert_response :success
  end
end
