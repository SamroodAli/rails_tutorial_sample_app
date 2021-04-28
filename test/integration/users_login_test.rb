require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
  end
  test "invalid login attempt" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: {  session: {
                                email:'',
                                password:''
                                }}
    assert_template "sessions/new"
    assert_not flash.empty?
    assert_select "div.alert.alert"
    get root_path
    assert flash.empty?
  end 

  test "Login with valid information" do
    get login_path
    post login_path, params: {session: {email:@user.email, password:'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]',login_path,0
    assert_select 'a[href=?]', user_path(@user)
    puts users_path(User.second)
  end

end
