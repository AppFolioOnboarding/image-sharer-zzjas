require File.expand_path(__dir__) + '/image_card.rb'
module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :root

      collection :images, locator: '.image_list', item_locator: '.image-card', contains: ImageCard

      def add_new_image!
        node.click_on('New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        tags = tags.sort unless tags.nil?

        images.any? { |img| img.url == url && (img.tags.sort == tags || tags.nil?) }
      end

      def clear_tag_filter!
        IndexPage.visit
      end

      def delete(url)
        to_delete = images.find { |img| img.url == url }
        to_delete&.delete_button&.node&.click
        yield node.driver.browser.switch_to.alert
      end

      def delete_and_confirm!(url)
        delete(url, &:accept)
        window.change_to(IndexPage)
      end

      def flash_message(_type)
        node.find('.alert-notice').text
      end
    end
  end
end
