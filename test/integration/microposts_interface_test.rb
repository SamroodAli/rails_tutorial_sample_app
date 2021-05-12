require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:samrood)
    @post = microposts(:orange)
  end

  test 'micropost interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    assert_no_difference 'Micropost.count' do
      post microposts_path, params:{micropost:{content:""}}
    end
    assert_select 'div#error_explanation'
    # testing valid submission
    content ="This micropost really ties the room together"
    assert_difference 'Micropost.count' do
      post microposts_path, params:{micropost:{content:content}}
    end
    assert_not_nil flash
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # delete a post
    assert_select 'a[href=?]',micropost_path(@post), text:'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
        delete micropost_path(first_micropost)
    end
    #visit a different user
    get user_path(users(:archer))
    assert_select 'a', text:'delete',count:0
  end

  test 'sidebar with microposts count and pluralization' do
    # testing pluralize and count using a user with more than 1 posts
    log_in_as(@user)
    get root_path
    assert_match '41 microposts', response.body
    #testing pluralize and count using a user with 1 post
    log_in_as(users(:lana))
    get root_path
    assert_match '1 micropost', response.body
    # 0 posts user
    log_in_as(users(:sanjeed))
    get root_path
    assert_match '0 micropost', response.body
  end
end
