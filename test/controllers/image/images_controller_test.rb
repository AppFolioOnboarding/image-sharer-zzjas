require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_image_path
    assert_response :success
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_path, params: { image: { url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png' } }
    end

    assert_redirected_to new_image_path
  end

end
