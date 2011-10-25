module Shop
  module Controllers
    module WelcomeController

      # If a logged in admin user logs out while impersonating a customer the
      # impersonated customer should be removed from the session.  We also want
      # to foget the current shop order as well.
      def logout_with_impersonation
        session[:impersonated_customer_id] = nil
        session[:shop_order] = nil
        logout_without_impersonation
      end

      def self.included(base)
        base.class_eval do
          alias_method_chain :logout, :impersonation
        end
      end

    end
  end
end
