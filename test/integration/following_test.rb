require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
    log_in_as(@user)
  end

  test 'following page' do
    get following_user_path(@user)
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select 'a[href=?]', user
    end
  end
end
