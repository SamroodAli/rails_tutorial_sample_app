require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:samrood)
  end

  test 'unsuccessful edit' do 
    get edit_user_path(@user)
    assert_response :success
  end

end
