require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
  end

  test 'should get new' do
    get signup_url
    assert_response :success
  end

  test 'should get edit page only when logged in' do
    get edit_user_path(@user)
    assert_redirected_to login_url
  end

  test 'should update user only when logged in' do
    patch user_path(@user), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  end
end
