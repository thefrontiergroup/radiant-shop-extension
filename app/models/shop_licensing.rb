class ShopLicensing < ShopAddress

  default_scope :conditions => { :of_type => 'licensing' }

  validates_presence_of :email

end
