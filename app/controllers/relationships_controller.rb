class RelationshipsController < ApplicationController


  test 'should redirect create when not logged in' do
    assert_not difference 'Relationship.count' do
      post relationships_path
    end
    assert_redirected_to login_url
  end

end
