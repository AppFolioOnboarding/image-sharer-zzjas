require File.expand_path('../../test_helper.rb', __dir__)

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Hello world!'
    assert_select 'a', href: new_image_path
  end
end
