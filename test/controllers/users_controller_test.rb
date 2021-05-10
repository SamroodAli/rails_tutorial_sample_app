require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user1 = users(:samrood)
    @user2 = users(:micheal)
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to login_url
  end 

  test 'should get new' do
    get signup_url
    assert_response :success
  end

  test 'should get edit page only when logged in' do
    get edit_user_path(@user1)
    assert_redirected_to login_url
  end

  test 'should update user1 only when logged in' do
    patch user_path(@user1), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect when logged in as another user' do
    log_in_as(@user2)
    patch user_path(@user1), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_redirected_to login_url
  end
end
