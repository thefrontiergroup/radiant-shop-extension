class ShopBilling < ShopAddress

  default_scope :conditions => { :of_type => 'billing' }

  validates_presence_of :email
  validates_presence_of :business

end
