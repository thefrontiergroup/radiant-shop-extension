class Admin::Shop::CustomersController < Admin::ResourceController
  model_class ShopCustomer
  paginate_models :per_page => 15

  before_filter :config_global
  before_filter :config_new,    :only => [ :new, :create ]
  before_filter :config_edit,   :only => [ :edit, :update ]
  before_filter :assets_global
  before_filter :assets_index,  :only => [ :index ]
  before_filter :assets_edit,   :only => [ :edit, :update ]
  before_filter :prepare_customer, :only => [ :impersonate ]

  skip_before_filter :authenticate, :only => [ :remove_impersonation ]
  skip_before_filter :authorize, :only => [ :remove_impersonation ]

  def impersonate
    impersonate_customer(@customer.id)
    redirect_to root_path
  end

  def remove_impersonation
    impersonate_customer(nil) # Removes the impersonated customer
    redirect_to admin_shop_customers_path
  end

  private

  def prepare_customer
    @customer = ShopCustomer.find(params[:id])
  end

  def config_global
    @inputs   ||= []
    @meta     ||= []
    @buttons  ||= []
    @parts    ||= []
    @popups   ||= []

    @inputs   << 'name'
    @inputs   << 'email'

    @meta     << 'login'
    @meta     << 'password'
    @meta     << 'password_confirmation'
  end

  def config_new
  end

  def config_edit
    @parts << 'orders'
    @parts << 'addresses'
  end

  def assets_global
    include_stylesheet 'admin/extensions/shop/edit'
    include_stylesheet 'admin/extensions/shop/index'
  end

  def assets_index
  end

  def assets_edit
  end

end
