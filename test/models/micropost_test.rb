require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:samrood)
    @micropost = Micropost.new(user_id: @user.id)
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id presence' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

end

