require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:samrood)
    @other_user = users(:micheal)
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
    get edit_user_path(@admin)
    assert_redirected_to login_url
  end

  test 'should update admin only when logged in' do
    patch user_path(@admin), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test 'should redirect when logged in as another user' do
    log_in_as(@other_user)
    patch user_path(@admin), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_redirected_to login_url
  end

    test 'should redirect destroy when not logged in' do
      assert_no_difference 'User.count' do
        delete user_path(@admin)
      end
      assert_redirected_to login_url
    end

    test 'should redirect when logged in as admin' do
      log_in_as(@other_user)
      assert_no_difference 'User.count' do
        delete user_path(@admin)
      end
      assert_redirected_to root_path
    end

    test 'should delete user when logged in as admin' do
      log_in_as(@admin)
      assert_difference 'User.count', -1 do
        delete user_path(@other_user)
      end
      assert_redirected_to users_path
    end
end
