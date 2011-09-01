class FormAddress
  include Forms::Models::Extension
  include Shop::Models::FormExtension

  attr_accessor :config, :data, :result, :gateway, :card, :billing, :shipping

  def create
    find_current_order      # locate the @order object

    create_result_object    # A default response object

    create_order_addresses  # Process the addresses

    @result
  end

  protected

  def create_result_object
    @result = {
      :order    => @order.id,
      :billing  => nil,
      :shipping => nil,
      :licensing => nil
    }
  end

  def create_order_addresses
    create_order_billing_address if billing?
    create_order_shipping_address
    create_order_licensing_address

    unless @billing.present? && @billing.valid? && @shipping.present? && @shipping.valid? && @licensing.present? && @licensing.valid?
      @form.redirect_to = :back
    end

    @result[:billing]   = @billing.present? && @billing.valid? && @billing.id
    @result[:shipping]  = @shipping.present? && @shipping.valid? && @shipping.id
    @result[:licensing] = @licensing.present? && @licensing.valid? && @licensing.id
  end

  def create_order_billing_address
    if @order.billing.present?
      @order.billing.update_attributes(billing)
    else
      @order.create_billing(billing)
    end
    @billing = @order.billing
  end

  def create_order_shipping_address
    if shipping?
      if @order.shipping.present?
        @order.shipping.update_attributes(shipping)
      else
        @order.create_shipping(shipping)
      end
    elsif @order.shipping.nil?
      @order.create_shipping(@billing.try(:attributes))
    end
    @shipping = @order.shipping
  end

  def create_order_licensing_address
    if licensing?
      if @order.licensing.present?
        @order.licensing.update_attributes(licensing)
      else
        @order.create_licensing(licensing)
      end
    elsif @order.licensing.nil?
      @order.create_licensing(@billing.try(:attributes))
    end
    @licensing = @order.licensing
  end

  # Returns an array of billing attributes
  def billing
    @data[:billing]
  end

  # Returns an array of shipping attributes
  def shipping
    @data[:shipping]
  end

  def licensing
    @data[:licensing]
  end

  # Returns whether form is configured for billing
  def billing?
    @config[:billing].present? and billing.present?
  end

  # Returns whether form is configured for shipping
  def shipping?
    @config[:shipping].present? and shipping.present?
  end

  # Returns whether form is configured for licensing
  def licensing?
    @config[:licensing].present? and licensing.present?
  end

end
