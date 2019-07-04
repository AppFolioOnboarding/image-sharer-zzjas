require 'test_helper'
require 'json'

class FeedbackControllerTest < ActionDispatch::IntegrationTest
  test_name = 'Test NaME'

  test 'should echo body if userName is not empty' do
    post api_feedbacks_path, as: :json, params: { userName: test_name }

    assert_response :success
    assert_equal test_name, JSON.parse(response.body)['userName']
  end

  test 'should send out HTTP 400 if userName is empty' do
    post api_feedbacks_path, as: :json, params: { userName: '' }

    assert_response :bad_request
  end
end
