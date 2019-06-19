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
    assert(image.errors.details[:url].any? { |e| e[:error] == :blank })
  end

  test 'validation for invalid url' do
    image = Image.new(url: 'abc.png')
    assert_not_predicate image, :valid?
    assert(image.errors.details[:url].any? { |e| e[:error] == :url })
  end

  test 'validation for invalid format' do
    image = Image.new(url: @test_url + '.pdf')
    assert_not_predicate image, :valid?
    assert(image.errors.details[:url].any? { |e| e[:error] == 'Invalid file format' })
  end
end
