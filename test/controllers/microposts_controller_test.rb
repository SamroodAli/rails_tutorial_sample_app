require "test_helper"

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end


  test 'should redirect create when not logged in' do
    assert_no_difference 'Micropost.count' do
      post :create, params: { micropost: {content:  "Lorem ipsum"}}
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Micropost.count' do
      delete :destroy, params:{id:@micropost}
    end
    assert_redirected_to login_url
  end

end
