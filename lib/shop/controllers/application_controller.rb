module Shop
  module Controllers
    module ApplicationController
      
      def self.included(base)
        base.class_eval do
          filter_parameter_logging :password, :password_confirmation, :credit
          
          def current_shop_order
            find_or_create_shop_order
          end
          
          def find_shop_order
            ShopOrder.find_by_session(request.session[:shop_order])
          end
          
          def find_or_create_shop_order
            begin
              @order = find_shop_order
            rescue
              @order = ShopOrder.create
              request.session[:shop_order] = @order.id
            end
            
            if current_user
              @order.update_attribute(:customer_id, (current_user.id))
              if current_user.billing.present? and @order.billing.blank?
                billing = ::ShopBilling.new(current_user.billing_attributes.reject { |k,v| k == 'id' })
                billing.save(false)
                @order.billing = billing
              end
              if current_user.shipping.present? and @order.shipping.blank?
                shipping = ::ShopBilling.new(current_user.shipping_attributes.reject { |k,v| k == 'id' })
                shipping.save(false)
                @order.shipping = shipping
              end
            end
            
            @order
          end
        end
      end
      
    end
  end
end
