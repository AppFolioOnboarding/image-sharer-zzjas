require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Hello world!'
    assert_select 'a', href: new_image_path
  end

  test 'should show list of images' do
    Image.create!(created_at: Time.zone.now - 5.minutes, url: 'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png')
    Image.create!(created_at: Time.zone.now - 20.minutes, url: 'https://homepages.cae.wisc.edu/~ece533/images/fruits.png')
    Image.create!(created_at: Time.zone.now - 15.minutes, url: 'https://homepages.cae.wisc.edu/~ece533/images/boat.png')
    Image.create!(created_at: Time.zone.now - 10.minutes, url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png')

    get root_url

    images = Image.order(created_at: :desc)
    idx = 0

    assert_select 'ul', 1
    assert_select 'ul li', 4
    assert_select 'ul li' do |items|
      items.each do |item|
        assert_select item, format('img[src="%<image_url>s"]', image_url: images[idx].url)
        assert_select item, 'p', 'Created at: ' + images[idx].created_at.to_s
        idx += 1
      end
    end
  end

  test 'should not show images' do
    get root_url

    assert_select 'ul', 1
    assert_select 'li', 0
  end

  test 'should show images with width 400' do
    Image.create!(url: 'https://via.placeholder.com/1500x1500.png')
    Image.create!(url: 'https://via.placeholder.com/15x15.png')

    get root_url

    assert_select 'ul li' do |items|
      items.each do |item|
        assert_select item, 'img[width="400"]'
      end
    end
  end

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
