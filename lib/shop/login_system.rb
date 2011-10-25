module Shop
  module LoginSystem
    # If the logged in user has a new shop order then we set that cart to be
    # the current cart
    def current_user(value=nil)
      current_user = super
      if current_user.present?
        current_order = current_user.orders.find_by_status('new')
        session[:shop_order] = current_user.orders.find_by_status('new') if current_order.present?
      end
      current_user
    end
  end
end
