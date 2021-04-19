require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User",email:"User@example.com")
    @user1 = User.new(name:"Just name")
  end

  test "should be valid" do
    assert @user.valid?
    refute @user1.valid?
  end
end
