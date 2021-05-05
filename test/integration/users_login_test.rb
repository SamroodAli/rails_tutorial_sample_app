require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
  end
  test 'invalid login attempt' do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: {
      email: 'samrood@example.com',
      password: 'invalid'
    } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select 'div.alert.alert'
    get root_path
    assert flash.empty?
  end

  test 'Login with valid information followed by logout' do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert_redirected_to @user
    follow_redirect!

    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, 0
    assert_select 'a[href=?]', logout_path, 1
    assert_select 'a[href=?]', user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    # simulating a user using multiple browser windows
    delete logout_path
    
    assert_redirected_to root_path
    follow_redirect!
    assert_select 'a[href=?]', login_path, 1
    assert_select 'a[href=?]', logout_path, 0
    assert_select 'a[href=?]', user_path(@user), 0
  end

  test 'login with remembering' do 
      log_in_as(@user,remember_me: '1')
      assert_not cookies[:remember_token].blank?
  end

  test 'login with no remembering' do 
      log_in_as(@user,remember_me: '0')
      assert cookies[:remember_token].blank?
  end


end
