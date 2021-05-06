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
    patch user_path(@user), params: {user: {
                              name: '', 
                              email:'invalid_email',
                              password:'foo',
                              password_confirmation:'nonmatchingpass'}}
    assert_template 'users/edit'
    assert_select 'div.alert'
    assert_select 'div#error_explanation li',4
  end

  test 'successful edit' do 
    get edit_user_path(@user)
    assert_response :success
    patch user_path(@user), params: {user: {
                              name: 'Samrood Ali', 
                              email:'example2@gmail.com',
                              password:'',
                              password_confirmation:''}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, 'Samrood Ali'
    assert_equal @user.email, 'example2@gmail.com'
  end
end
