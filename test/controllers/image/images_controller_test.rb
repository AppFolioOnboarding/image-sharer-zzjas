require 'test_helper'

def test_destroy
  test 'should delete an image' do
    image = Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')

    assert_difference('Image.count', -1) do
      delete image_path(image)
    end

    assert_equal 'You have successfully deleted the image.', flash[:notice]
  end

  test 'should preserve tag after delete' do
    image = Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')
    delete image_path(image), params: { tag: 'a' }

    assert_redirected_to root_url(tag: 'a')
  end

  test 'should have no error when delete non-existing image' do
    assert_no_difference('Image.count') do
      delete image_path(-1)
    end

    assert_equal 'You have successfully deleted the image.', flash[:notice]
  end

  test 'should show delete link for each image in index page' do
    Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')
    Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')
    Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')

    get root_url

    Image.all.each do |image|
      assert_select "a[href='/images/#{image.id}']"
    end
  end

  test 'should how delete link in show page' do
    image = Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')

    get image_path(image)

    assert_select "a[href='/images/#{image.id}']"
  end
end

def test_index_page
  test 'should get index' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Hello world!'
    assert_select 'a', href: new_image_path
  end

  test 'should show list of images' do
    Image.create!(created_at: Time.zone.now - 5.minutes,
                  url: 'https://homepages.cae.wisc.edu/~ece533/images/arctichare.png',
                  tag_list: 'a')
    Image.create!(created_at: Time.zone.now - 20.minutes,
                  url: 'https://homepages.cae.wisc.edu/~ece533/images/fruits.png',
                  tag_list: 'a')
    Image.create!(created_at: Time.zone.now - 15.minutes,
                  url: 'https://homepages.cae.wisc.edu/~ece533/images/boat.png',
                  tag_list: 'a')
    Image.create!(created_at: Time.zone.now - 10.minutes,
                  url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                  tag_list: 'a')

    get root_url

    images = Image.order(created_at: :desc)
    idx = 0

    assert_select 'ul.image_list', 1
    assert_select 'ul.image_list > li', 4
    assert_select 'ul.image_list > li' do |items|
      items.each do |item|
        assert_select item, format('img[src="%<image_url>s"]', image_url: images[idx].url)
        assert_select item, 'p', 'Created at: ' + images[idx].created_at.to_s
        idx += 1
      end
    end
  end

  test 'should not show images' do
    get root_url

    assert_select 'ul.image_list', 1
    assert_select 'li', 0
  end

  test 'should show images with width 400' do
    Image.create!(url: 'https://via.placeholder.com/1500x1500.png', tag_list: 'a')
    Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a')

    get root_url

    assert_select 'ul.image_list > li', 2
    assert_select 'ul.image_list > li' do |items|
      items.each do |item|
        assert_select item, 'img[width="400"]'
      end
    end
  end

  test 'should show images with tags' do
    image = Image.create!(url: 'https://via.placeholder.com/15x15.png', tag_list: 'a, b, c')

    get root_url

    image.tag_list.each do |tag|
      assert_select 'ul.tag_list > li a', tag
    end
  end

  test 'should only show images with tag a' do
    image_tagged_with_a = Image.create!(url: 'https://via.placeholder.com/10x10.png', tag_list: 'a, b, c')
    image_not_tagged_with_a = Image.create!(url: 'https://via.placeholder.com/20x20.png', tag_list: 'b, c, d')

    image_tagged_with_only_a = Image.create!(url: 'https://via.placeholder.com/30x30.png', tag_list: 'a')
    image_tagged_with_aaa = Image.create!(url: 'https://via.placeholder.com/40x40.png', tag_list: 'aaa')

    get root_url, params: { tag: 'a' }

    assert_response :success
    assert_select_img image_tagged_with_a
    assert_select_img image_not_tagged_with_a, count: 0

    assert_select_img image_tagged_with_only_a
    assert_select_img image_tagged_with_aaa, count: 0
  end

  test 'should show found no image when no image with a tag exists' do
    image_tagged_with_only_a = Image.create!(url: 'https://via.placeholder.com/30x30.png', tag_list: 'a')

    get root_url, params: { tag: 'b' }

    assert_select_img image_tagged_with_only_a, count: 0
    assert_equal 'No image with tag b found.', flash[:notice]
  end

  test 'tag link should point to filtered index page' do
    Image.create!(url: 'https://via.placeholder.com/10x10.png', tag_list: 'a, b, c')

    get root_url

    Image.last.tag_list.each do |tag|
      assert_select format('ul.tag_list li a[href="%<link>s"]', link: root_url(tag: tag))
    end
  end
end

def test_new_page
  test 'should get new' do
    get new_image_path
    assert_response :success
    form_exists url: ''
    form_exists tag_list: ''
  end

  test 'should create image' do
    img = { image: { url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png', tag_list: 'a' } }
    assert_difference('Image.count') do
      post images_path, params: img
    end

    assert_redirected_to image_path(Image.last)
    assert_equal 'Image was successfully created.', flash[:notice]
  end

  test 'shoud stay when fail to create new image' do
    img = { image: { url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.pdf', tag_list: 'a, b, c' } }
    assert_no_difference('Image.count') do
      post images_path, params: img
    end

    assert_response :unprocessable_entity
    assert_select '.error', value: 'Invalid file format'
    form_exists url: img[:image][:url], tag_list: img[:image][:tag_list]
    assert_equal 'Failed to create image.', flash[:notice]
  end

  test 'should store tags' do
    post images_path, params: {
      image: {
        url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
        tag_list: 'a, b, c'
      }
    }

    assert_redirected_to image_path(Image.last)
    assert_equal Image.last.tag_list[0], 'a'
    assert_equal Image.last.tag_list[1], 'b'
    assert_equal Image.last.tag_list[2], 'c'
  end
end

def test_show_page
  test 'should show image' do
    image = Image.create!(url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png', tag_list: 'a')

    get image_path(image)

    assert_response :ok
    assert_select 'img', src: image.url
  end

  test 'should not show image' do
    get image_path(-1)

    assert_redirected_to new_image_path
    assert_equal 'Failed to create image.', flash[:notice]
  end

  test 'should show tags' do
    image = Image.create!(url: 'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                          tag_list: 'a, b, c')

    get image_path(image)

    assert_response :ok
    assert_select 'ul li', 3
    image.tag_list.each do |tag|
      assert_select 'ul li a', tag
    end

    image.tag_list.each do |tag|
      assert_select format('ul li a[href="%<link>s"]', link: root_url(tag: tag))
    end
  end
end

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test_index_page
  test_new_page
  test_show_page
  test_destroy

  private

  def form_exists(value_hash)
    assert_select 'form'

    value_hash.each do |k, v|
      assert_select format('input#image_%<field>s[value=?]', field: k.to_s), v
    end

    assert_select 'input[type=submit]', value: 'Create'
  end

  def assert_select_img(image, count: 1)
    assert_select "img[src='#{image.url}']", count: count
  end
end
