module Shop
  module Controllers
    module WelcomeController

      def logout_with_impersonation
        session[:impersonated_customer_id] = nil
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
