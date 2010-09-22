class FormCheckout
  include Forms::Models::Extension
  
  def create
    @result = {
      :checkout => {
        :billing  => false,
        :shipping => false,
        :gateway  => false,
        :card     => false
      }
    }
    
    @success= true
    @order  = ShopOrder.find(@page.request[:session][:shop_order])
    
    if @config[:address].present?
      # If the form was configured for address
      build_addresses
    end
    
    if @config[:gateway].present? and card
      # If the form was configured for gateway
      build_gateway
      build_card
      
      @gateway.purchase(@order.price, @card, @config[:order])
    end
    
    @result
  end
  
  private
  
    # Assigns a shipping and billing address to the @order
    def build_addresses
      if billing.present?
        build_billing_address
      end
      
      if shipping.present?
        build_shipping_address
      elsif billing.present?
        @shipping = @billing
        @order.update_attribute(:shipping_id, @shipping.id)
      end
      
      @result[:checkout][:billing]  = @order.billing.present? ? @order.billing : false
      @result[:checkout][:shipping] = @order.shipping.present? ? @order.shipping : false
      
      unless @order.billing.present? and @order.shipping.present?
        @form.redirect_to = :back
      end
    end
    
    def build_billing_address
      # Billing Address
      if billing['id'].present?
        # Use an existing Address and update its values
        @billing = ShopAddress.find(billing['id'])
        @billing.update_attributes(billing)
        @order.update_attribute(:billing_id, @billing.id)

      elsif @order.billing.present?
        # Use the current billing and update its values
        @billing = @order.billing
        @billing.update_attributes(billing)
        
      else
        # Create a new address with these attributes
        @order.update_attributes({ :billing_attributes => billing })
        @billing = @order.billing
        
      end
    end
    
    def build_shipping_address
      # Shipping Address
      if shipping['id'].present?
        # Use an existing Address and update its values
        @shipping = ShopAddress.find(shipping['id'])
        @shipping.update_attributes(shipping)
        @order.update_attribute(:shipping_id, @shipping.id)
        
      elsif @order.shipping.present?
        # Use the current shipping and update its values
        @shipping = @order.shipping
        @shipping.update_attributes(shipping)
        
      elsif shipping.values.all?(&:blank?) or shipping == billing
        # We haven't set a shipping, or we have copied billing, so use billing
        @shipping = @billing
        @order.update_attribute(:shipping_id, @shipping.id)
        
      else
        # Create a new address with these attributes
        @order.update_attributes!({ :shipping_attributes => shipping })
        @shipping = @order.shipping
      end
    end

    # Creates a gateway instance variable based off the form configuration
    def build_gateway
      ActiveMerchant::Billing::Base.mode = :test if testing
      
      begin
        @gateway = ActiveMerchant::Billing.const_get("#{gateway}Gateway").new(gateway_credentials)
        @result[:checkout][:gateway] = true
      end
    end

    # Builds an ActiveMerchant card using the submitted card information
    def build_card
      if card.present?
        @card = ActiveMerchant::Billing::CreditCard.new({
          :number             => card_number,
          :month              => card_month,
          :year               => card_year,
          :first_name         => card_first_name,
          :last_name          => card_last_name,
          :verfication_value  => card_verification,
          :type               => card_type
        })
        
        @result[:checkout][:card] = {
          :valid  => @card.valid?,
          :name   => "#{card_first_name} #{card_last_name}",
          :month  => card_month,
          :year   => card_year,
          :type   => card_type
        }
      end
    end
    
    def success?
      @success
    end
  
    def testing
      @config[:test].present?
    end
    
    def billing
      billing   = @data['billing'] # Array of billing attributes      
    end
    
    def shipping
      shipping  = @data['shipping'] # Array of shipping attributes      
    end
    
    def gateway
      @config[:gateway][:name]
    end
    
    def gateway_credentials
      @config[:gateway][:credentials]
    end
    
    def card
      @data['card']
    end
    
    def card_number
      card['number'].to_s.gsub('-', '').to_i
    end
    
    def card_month
      card['month'].to_i
    end
    
    def card_year
      card['year'].to_i
    end
    
    def card_type
      card['type']
    end
    
    def card_verification
      card['verification']
    end
    
    def card_names
      return @card_names if @card_names.present?
      @card_names = @data['card']['name'].split(' ')
    end
    
    def card_first_name
      card_names[0, card_names.length - 1].join(' ')
    end
    
    def card_last_name
      card_names[-1]
    end
    
end