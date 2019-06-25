module PageObjects
  module Images
    class NewPage < PageObjects::Document
      path :new_image
      path :images

      form_for :new_image do
        element :url_box, locator: '#image_url'
        element :tag_list_box, locator: '#image_tag_list'
        element :create_button, locator: 'input[type="submit"]'
      end

      def create_image!(url: nil, tags: nil)
        url_box.set(url) unless url.nil?
        tag_list_box.set(tags) unless url.nil?

        create_button.node.click

        window.change_to(ShowPage, NewPage)
      end

      def error_message
        element(locator: '.error').text
      end
    end
  end
end
