require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:samrood)
    remember(@user)
  end

  test 'testing remember and forget method' do
    assert_not_nil @user.remember_digest
    forget(@user)
    assert_nil @user.remember_digest
  end

  test 'current user returns user when sessions is nil but cookies has user data' do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test 'current user returns nil when remember digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end
