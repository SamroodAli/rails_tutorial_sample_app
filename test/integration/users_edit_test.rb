require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:samrood)
  end
  
  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: {
      name: '',
      email: 'invalid_email',
      password: 'foo',
      password_confirmation: 'nonmatchingpass'
    } }
    assert_template 'users/edit'
    assert_select 'div.alert'
    assert_select 'div#error_explanation li', 4
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_path(@user)
    assert_not_nil session[:forwarding_url]
    assert_redirected_to login_url
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    patch user_path(@user), params: { user: {
      name: 'Samrood Ali',
      email: 'example2@gmail.com',
      password: '',
      password_confirmation: ''
    } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, 'Samrood Ali'
    assert_equal @user.email, 'example2@gmail.com'
  end
end
