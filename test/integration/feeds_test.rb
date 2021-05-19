require "test_helper"

class FeedsTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
  end


  test 'feed on home page' do
    get root_path
    log_in_as(@user)
    @user.feed.paginate(page: 1).each do |micropost| 
        assert_match CGI.escapeHTML(micropost.content), response.body
    end
  end
end
