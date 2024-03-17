# frozen_string_literal: true

require 'test_helper'

class RedirectControllerTest < ActionDispatch::IntegrationTest
  test 'should get feedback' do
    get redirect_feedback_url
    assert_response :success
  end
end
