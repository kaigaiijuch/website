# frozen_string_literal: true

require 'test_helper'

class FeedbacksControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_feedback_path
    assert_response :success
  end
end
