require "test_helper"

class RelationshipsControllerTest < ActionDispatch::IntegrationTest

  test 'should redirect create when not logged in' do
    assert_no_difference 'Relationship.count' do
      post relationships_path, params: {follower_id:2 }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in ' do
    assert_no_difference 'Relationship.count' do
      delete relationships_path, params: { id: relationships(:one)}
    end
    assert_redirected_to login_url
  end
end
