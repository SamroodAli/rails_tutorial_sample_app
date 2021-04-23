require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test 'should get sessions#new for user login' do
    get login_path
    assert_response :success
  end
end
