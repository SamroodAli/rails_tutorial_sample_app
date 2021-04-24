require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
