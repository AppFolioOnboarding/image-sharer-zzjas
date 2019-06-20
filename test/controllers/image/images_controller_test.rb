require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get new_image_path
    assert_response :success
    form_exists ''
  end

  test 'should create image' do
    assert_difference('Image.count') do
      post images_path, params: { image: { url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png' } }
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created.', flash[:notice]
  end

  test 'shoud stay when fail to create new image' do
    img = { image: { url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.pdf' } }
    assert_no_difference('Image.count') do
      post images_path, params: img
    end

    assert_response :unprocessable_entity
    assert_select '.error', value: 'Invalid file format'
    form_exists img[:image][:url]
    assert_equal 'Failed to create image.', flash[:notice]
  end

  test 'should show image' do
    image = Image.create!(url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png')

    get image_path(image)

    assert_response :ok
    assert_select 'img', src: image.url
  end

  test 'should not show image' do
    get image_path(-1)

    assert_redirected_to new_image_path
    assert_equal 'Failed to create image.', flash[:notice]
  end

  private

  def form_exists(should_have_value_of)
    assert_select 'form'
    assert_select 'input', value: should_have_value_of
    assert_select 'input[type=submit]', value: 'Create'
  end
end
