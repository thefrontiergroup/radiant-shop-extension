module Shop
  module Tags
    module Address
      include Radiant::Taggable

      # Expand if the address has been assigned to the order
      desc %{
        Expand if an address has been assigned to the order

        @type@ = (billing)|(shipping)|(licensing)
      }
      [:billing, :shipping, :licensing].each do |of_type|
        tag "shop:cart:#{of_type}" do |tag|
          tag.locals.send(of_type, Shop::Tags::Helpers.current_address(tag, of_type))

          tag.expand
        end

        # Expand if an address has been assigned to the order
        desc %{ Expand if an address has been assigned to the order }
        tag "shop:cart:#{of_type}:if_#{of_type}" do |tag|
          tag.expand if tag.locals.send(of_type).present?
        end

        # Expand if an address has not been assigned to the order
        desc %{ Expand if an address has not been assigned to the order }
        tag "shop:cart:#{of_type}:unless_#{of_type}" do |tag|
          tag.expand unless tag.locals.send(of_type).present?
        end

        [:id, :name, :phone, :business, :email, :unit, :street_1, :street_2, :city, :state, :country, :postcode].each do |method|
          tag "shop:cart:#{of_type}:#{method}" do |tag|
            tag.locals.send(of_type).try(method)
          end
        end

        tag "shop:cart:#{of_type}:login" do |tag|
          UserActionObserver.current_user.try(:login)
        end
      end
    end
  end
end
