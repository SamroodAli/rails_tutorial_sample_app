require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end


  test 'should redirect create when not logged in' do
    assert_no_difference 'Micropost.count' do
      post :create, micropost: {content:  "Lorem ipsum"}
    end
    assert_redirected_to login_url
  end
end
