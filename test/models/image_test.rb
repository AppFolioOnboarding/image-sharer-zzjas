require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  setup do
    @test_url = 'https://homepages.cae.wisc.edu/~ece533/images/airplane'
  end

  test 'validation for correct url' do
    assert_predicate Image.new(url: @test_url + '.png'), :valid?
  end

  test 'validation for empty' do
    image = Image.new(url: '')
    assert_not_predicate image, :valid?
    assert image.errors.added?(:url, :blank)
  end

  test 'validation for invalid url' do
    image = Image.new(url: 'abc.png')
    assert_not_predicate image, :valid?
    assert image.errors.added?(:url, :url)
  end

  test 'validation for invalid format' do
    image = Image.new(url: @test_url + '.pdf')
    assert_not_predicate image, :valid?
    assert image.errors.added?(:url, 'Invalid file format')
  end

  test 'validation for parsed tag' do
    image = Image.new(url: @test_url + '.png')
    image.tag_list.add('a', 'b', 'c')
    image.save

    assert_predicate image, :valid?
  end

  test 'validation for not parsed tag' do
    image = Image.new(url: @test_url + '.png')
    image.tag_list.add('a, b, c')
    image.save

    assert_not_predicate image, :valid?
    assert image.errors.added?(:tag, 'Cannot parse the tag')
  end
end
