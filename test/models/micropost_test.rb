require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:samrood)
    @micropost = @user.microposts.build(content:"Lorem ipsum")
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  test 'user id presence' do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end


  test 'content should be utmost 140 characters' do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

end

