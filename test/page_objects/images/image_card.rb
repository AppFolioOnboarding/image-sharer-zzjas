module PageObjects
  module Images
    class ImageCard < AePageObjects::Element
      element :delete_button, locator: '.delete-button'

      collection :tag_list, locator: 'ul', item_locator: 'li' do
        element :tag, locator: 'a'
      end

      def url
        node.find('img')[:src]
      end

      def tags
        tag_list.map do |tag_li|
          tag_li.tag.text
        end
      end

      def click_tag!(tag_name)
        # TODO
      end
    end
  end
end
