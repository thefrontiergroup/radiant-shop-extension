class ShopLineItem < ActiveRecord::Base
  
  belongs_to  :order,       :class_name   => 'ShopOrder'
  has_one     :customer,    :class_name   => 'User', :through => :order, :source => :customer
  belongs_to  :item,        :polymorphic  => true
  
  before_validation         :adjust_quantity, :copy_price
  
  validates_presence_of     :item, :item_price
  
  validates_uniqueness_of   :item_id, :scope => [ :order_id, :item_type ]
  
  validates_numericality_of :item_price, :greater_than => 0.00,    :allow_nil => true,     :precisions => 2

  alias_attribute :value, :item_price
  
  def cost
    (item_price * quantity)
  end

  def price
    result = cost
    
    result += tax if Radiant::Config['shop.tax_strategy'] === 'exclusive'

    result
  end
  
  def tax
    percentage = Radiant::Config['shop.tax_percentage'].to_f * 0.01
    
    case Radiant::Config['shop.tax_strategy']
    when 'inclusive'
      tax = cost - (cost / (1 + percentage))
    when 'exclusive'
      tax = cost * percentage
    else
      tax = 0
    end
    
    BigDecimal.new(tax.to_s)
  end

  def weight
    warn 'Not yet fully implemented'
    (item.weight.to_f * self.quantity.to_f).to_f
  end
  
  # Overloads the base to_json to return what we want
  def to_json(*attrs); super self.class.params; end
  
  class << self
    
    # Returns attributes attached to the product
    def attrs
      [ :id, :quantity ]
    end
    
    # Returns methods with usefuly information
    def methds
      [ :price, :weight ]
    end
    
    # Returns a custom hash of attributes on the product
    def params
      { :only  => attrs, :methods => methds }
    end
    
  end
  
protected
  
  def adjust_quantity
    self.quantity = [1,self.quantity].max
  end
  
  def copy_price
    self.item_price = item.price unless item_price.present?
  end
  
end
