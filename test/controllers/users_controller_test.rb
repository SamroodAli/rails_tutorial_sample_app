require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:samrood)
    @micheal = users(:micheal)
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
    log_in_as(@micheal)
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
    log_in_as(@micheal)
    assert_no_difference 'User.count' do
      delete user_path(@admin)
    end
    assert_redirected_to root_path
  end

  test 'should delete user when logged in as admin' do
    log_in_as(@admin)
    assert_difference 'User.count', -1 do
      delete user_path(@admin)
    end
    assert_redirected_to users_path
  end

  test 'should not allow the admin attribute to be edited via the web' do
    log_in_as(@admin)
    assert_not @micheal.admin?
    patch user_path(@micheal), params: { user:{
                      name:@micheal.name,
                      email:@micheal.email,
                      password:"password",
                      password_confirmation:'password',
                      admin:true}
                    }
  end

  test 'should redirect following when not logged in' do
    get following_user_path(@admin)
    assert_redirected_to login_url
  end

  test 'should redirect followers when not logged in' do
    get followers_user_path(@admin)
    assert_redirected_to login_url
  end
end
