class Image < ApplicationRecord
  validates :url, presence: true
  validates :url, url: true
  validate :url_should_have_correct_format

  def url_should_have_correct_format
    formats = %w[jpg png jpeg gif webp]

    errors.add(:url, 'Invalid file format') if formats.none? { |format| url.end_with?('.' + format) }
  end
end
