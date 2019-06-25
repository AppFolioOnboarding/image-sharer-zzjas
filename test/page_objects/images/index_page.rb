require File.expand_path(__dir__) + '/image_card.rb'
module PageObjects
  module Images
    class IndexPage < PageObjects::Document
      path :root

      collection :images, locator: '.image_list', item_locator: '.image-card', contains: ImageCard do
        def view!
          # TODO
        end
      end

      def add_new_image!
        node.click_on('New Image')
        window.change_to(NewPage)
      end

      def showing_image?(url:, tags: nil)
        tags = tags.sort unless tags.nil?

        images.any? { |img| img.url == url && (img.tags.sort == tags || tags.nil?) }
      end

      def clear_tag_filter!
        # TODO
      end
    end
  end
end
