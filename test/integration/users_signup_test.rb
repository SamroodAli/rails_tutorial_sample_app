require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'should reject an invalid user' do
    get signup_path
    assert_response :success

    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: 'samrood', email: 'user@invalid',
                                         password: 'foo', password_confirmation: 'bar' } }
    end

    assert_template 'users/new'
    assert_select 'div.field_with_errors',6
    assert_select 'div#error_explanation',1
    assert_select 'div#error_explanation ul li', 3
  end

  test "should accept a valid user" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user:
                                { name: 'samrood',
                                  email: "example@example.com",
                                  password: 'passpass',
                                  password_confirmation: 'passpass'}
                                }
    end
  end
end
