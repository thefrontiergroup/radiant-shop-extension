class ShopLicensing < ShopAddress

  default_scope :conditions => { :of_type => 'licensing' }

end
