require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:samrood)
    @other_user = users(:micheal)
  end
  test 'index including pagination' do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination',count:2
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]',user_path(@admin),text: @admin.name
    end
  end


  test 'index as non admin' do
    log_in_as(@other_user)
    get users_path
    assert_select 'a', text:'delete',count:0
  end
end
