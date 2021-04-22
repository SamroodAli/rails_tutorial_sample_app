require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'should reject an invalid user' do
    get signup_path
    assert_response :success
    post users_path, params: { users: { name: 'samrood', email: 'user@invalid',
                                        password: 'foo', password_confirmation: 'bar' } }

  end
end
