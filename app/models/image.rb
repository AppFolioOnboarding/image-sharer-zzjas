class Image < ApplicationRecord
  acts_as_taggable

  validates :url, presence: true
  validates :url, url: true
  validate :url_should_have_correct_format
  validate :tag_is_parsed

  def url_should_have_correct_format
    formats = %w[jpg png jpeg gif webp]

    errors.add(:url, 'Invalid file format') if formats.none? { |format| url.end_with?('.' + format) }
  end

  def tag_is_parsed
    tag_list.each do |tag|
      errors.add(:tag, 'Cannot parse the tag') if tag.include? ','
    end
  end
end
