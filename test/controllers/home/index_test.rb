require File.expand_path('../../test_helper.rb', __dir__)

class HomeControllerTest < ActionDispatch::IntegrationTest
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
end
