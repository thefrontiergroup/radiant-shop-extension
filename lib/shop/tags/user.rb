module Shop
  module Tags
    module User
      include Radiant::Taggable

      # Expand if customer is configured
      desc %{ Expand if customer is impersonating }
      tag 'user:if_impersonating' do |tag|
        tag.expand if impersonating_customer?
      end

      # Expand unless customer is configured
      desc %{ Expand unless customer is impersonating }
      tag 'user:unless_impersonating' do |tag|
        tag.expand unless impersonating_customer?
      end

      def current_user_with_impersonation
        current_impersonated_customer || current_user_without_impersonation
      end

      def impersonating_customer?
        current_impersonated_customer.present?
      end

      def current_impersonated_customer
        if customer_id = request.session[:impersonated_customer_id]
          ::User.find_by_id(customer_id)
        end
      end

    end
  end
end
