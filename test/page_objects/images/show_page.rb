require File.expand_path(__dir__) + '/image_card.rb'
module PageObjects
  module Images
    class ShowPage < PageObjects::Document
      path :image

      element :image_card, is: ImageCard, locator: '.image-card'

      def image_url
        image_card.url
      end

      delegate :tags, to: :image_card

      def go_back_to_index!
        IndexPage.visit
      end

      def flash_message(_type)
        node.find('.alert-notice').text
      end
    end
  end
end
