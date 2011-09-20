class ShopOrder < ActiveRecord::Base

  default_scope :order => 'shop_orders.updated_at DESC'

  has_one    :payment,      :class_name => 'ShopPayment',   :foreign_key => :order_id,  :dependent => :destroy
  has_many   :line_items,   :class_name => 'ShopLineItem',  :foreign_key => :order_id,  :dependent => :destroy, :after_remove => :line_item_removed, :after_add => :line_item_added

  belongs_to :created_by,   :class_name => 'User'
  belongs_to :updated_by,   :class_name => 'User'
  belongs_to :customer,     :class_name => 'User',          :foreign_key => :customer_id

  has_one    :billing,      :class_name => 'ShopBilling',   :as => :addressable
  has_one    :shipping,     :class_name => 'ShopShipping',  :as => :addressable
  has_one    :licensing,    :class_name => 'ShopLicensing', :as => :addressable

  accepts_nested_attributes_for :line_items,  :reject_if => :all_blank
  accepts_nested_attributes_for :billing,     :reject_if => :all_blank
  accepts_nested_attributes_for :shipping,    :reject_if => :all_blank
  accepts_nested_attributes_for :licensing,   :reject_if => :all_blank

  def cost
    line_items.map(&:cost).sum
  end

  def price
    line_items.map(&:price).sum
  end

  def tax
    line_items.map(&:tax).sum
  end

  def weight
    line_items.map(&:weight).sum
  end

  def add!(id, quantity = nil, type = nil)
    result = true

    line_item = line_items.find_by_id(id)
    if line_item.present?
      return false unless line_item.purchaseable?

      quantity = line_item.quantity + quantity.to_i
      modify!(id,quantity)

    else
      quantity  ||= 1
      type      ||= 'ShopProduct'


      if line_items.exists?({:item_id => id, :item_type => type})
        line_item = line_items.first(:conditions => {:item_id => id, :item_type => type})
        quantity  = line_item.quantity + quantity.to_i

        modify!(line_item.id, quantity)
      else
        line_item = line_items.build(:item_id => id, :item_type => type, :quantity => quantity)
        return false unless line_item.purchaseable?
        line_item.save!
      end
    end

    result
  end

  def add(*attrs)
    add!(*attrs)
    true
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
    false
  end

  def modify!(id, quantity = 1, discount_code = nil)
    quantity = quantity.to_i
    if quantity <= 0
      remove!(id)
    else
      line_item = line_items.find(id)
      raise ArgumentError unless line_item.purchaseable?
      line_item.update_attributes! :quantity => quantity, :discount_code => discount_code
    end
  end

  def modify(*attrs)
    modify!(*attrs)
    true
  rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved, ArgumentError
    false
  end

  def remove!(id)
    line_item = line_items.find(id)
    raise ArgumentError unless line_item.purchaseable?
    line_items.destroy(id)
    true
  end

  def remove(*attrs)
    remove!(*attrs)
    true
  rescue ActiveRecord::RecordNotFound, ArgumentError
    false
  end

  def clear!
    line_items.destroy_all
  end

  def quantity
    self.line_items.sum(:quantity)
  end

  def new?
    self.status === 'new'
  end

  def paid?
    return false unless self.payment.present?
    self.payment.amount === self.price and self.status === 'paid'
  end

  def shipped?
    self.status === 'shipped'
  end

  def line_item_added(line_item)
  end

  def line_item_removed(line_item)
  end

  class << self

    # A hookable method used by the site controller
    def find_by_session(session)
      find(session)
    end

    # Will scope the contained find calls to a specific status
    def scope_by_status(status)
      case status
      when 'new', 'shipped', 'paid'
        with_scope(:find => { :conditions => {:status => status}}) do
          yield
        end
      else
        yield
      end
    end

    def params
      [ :id, :notes, :status ]
    end
  end

end
