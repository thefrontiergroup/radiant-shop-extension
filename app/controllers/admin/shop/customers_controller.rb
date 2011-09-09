class Admin::Shop::CustomersController < Admin::ResourceController
  model_class User
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

  # Overwrite load_models in order to scope the list of users to only customer
  # type users
  def load_models
    User.customer_scope do
      super
    end
  end

  def impersonate
    impersonate_customer(@customer.id)
    redirect_to root_path
  end

  def remove_impersonation
    stop_impersonating_customer
    redirect_to admin_shop_customers_path
  end

  def refresh
    raise 'not yet implemented'

    # FIXME: This will need to update user credentials from the web services
    # layer
    #
    # Currently there is no API endpoint on the web services layer to get this
    # data. Once it is available then this will need to be implemented.
    redirect_to :action => :index
  end

  private

  def prepare_customer
    @customer = User.find(params[:id])
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
