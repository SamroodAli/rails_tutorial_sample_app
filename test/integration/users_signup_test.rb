require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(name:'Samrood',email:'valid@gmail.com',password:'passpass',
                     password_confirmation:'passpass')
  end

  test "should get signup page" do
    get signup_path
    assert_response :success
  end
end
