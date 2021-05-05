require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:samrood)
    remember(@user)
  end

  test 'current user' do
    assert_equal @user, current_user
    assert is_logged_in?
  end
end
