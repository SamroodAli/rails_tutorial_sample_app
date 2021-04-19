require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User",email:"User@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = '   '
    refute @user.valid?
  end

  test 'name should not be too long' do
    @user.name = "a" * 51
    refute @user.valid?

  end

  test "email should be present" do
    @user.email = '   '
    refute @user.valid?
  end

  test "email should be unique" do
    @user.save
    @new_user = User.new(name:'Another User',email:"User@example.com")
    refute @new_user.valid?
  end
  
end
