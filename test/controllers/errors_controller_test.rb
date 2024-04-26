# frozen_string_literal: true

require 'test_helper'

class ErrorsControllerTest < ActionDispatch::IntegrationTest
  test 'should get not_found' do
    get not_found_path
    assert_response :success # should be 404 but static page is okay to be 200
  end
end
