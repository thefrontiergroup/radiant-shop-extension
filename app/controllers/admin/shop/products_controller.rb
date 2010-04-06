class Admin::Shop::ProductsController < Admin::ResourceController
  model_class ShopProduct
  helper :shop

  # GET /admin/shop/products
  # GET /admin/shop/products.js
  # GET /admin/shop/products.xml
  # GET /admin/shop/products.json                                 AJAX and HTML
  #----------------------------------------------------------------------------
  def index
    @shop_categories = ShopCategory.search(params[:psearch])
    @shop_products = ShopProduct.search(params[:psearch])
    attr_hash = {
      :include => {:category => {:only => [:id, :title]} },
      :only => [:id, :sku, :handle, :description, :created_at, :updated_at, :price, :title]
    }
    respond_to do |format|
      format.html { render }
      format.js { render :partial => '/admin/shop/products/excerpt', :collection => @shop_products }
      format.xml { render :xml => @shop_products.to_xml(attr_hash) }
      format.json { render :json => @shop_products.to_json(attr_hash) }
    end
  end

  # GET /admin/shop/products/new
  # GET /admin/shop/products/new.js
  # GET /admin/shop/products/new.xml
  # GET /admin/shop/products/new.json                             AJAX and HTML
  #----------------------------------------------------------------------------
  def new
    @shop_product = ShopProduct.new(params[:shop_product])
    
    if params[:shop_product].nil? or @shop_product.category
      respond_to do |format|
        format.html { render }
      end
    else
      redirect_to admin_shop_products_path
    end
  end

  # GET /admin/shop/products/1
  # GET /admin/shop/products/1.js
  # GET /admin/shop/products/1.xml
  # GET /admin/shop/products/1.json                               AJAX and HTML
  #----------------------------------------------------------------------------
  def show
    @shop_product = ShopProduct.find(params[:id])
    attr_hash =  {  :include => {:category => {:only => [:id, :title]}},
                    :only => [:id, :sku, :handle, :created_at, :updated_at, :description, :price, :title] 
    }
    respond_to do |format|
      format.html { render }
      format.js { render :partial => '/admin/shop/products/product', :locals => { :product => @shop_product } }
      format.xml { render :xml => @shop_product.to_xml(attr_hash) }
      format.json { render :json => @shop_product.to_json(attr_hash) }
    end
  end

  # POST /admin/shop/products
  # POST /admin/shop/products.js
  # POST /admin/shop/products.xml
  # POST /admin/shop/products.json                                AJAX and HTML
  #----------------------------------------------------------------------------
  def create
    @shop_product = ShopProduct.new(params[:shop_product])
    
    if @shop_product.save
      respond_to do |format|
        format.html { 
          flash[:notice] = "Product created successfully."
          redirect_to admin_shop_products_path 
        }
        format.js { render :partial => '/admin/shop/products/excerpt', :locals => { :excerpt => @shop_product } }
        format.xml { redirect_to "/admin/shop/products/#{@shop_product.id}.xml" }
        format.json { redirect_to "/admin/shop/products/#{@shop_product.id}.json" }
      end
    else
      respond_to do |format|
        format.html { 
          flash[:error] = "Unable to create new product."
          render
        }
        format.js { render :text => @shop_product.errors.to_json, :status => :unprocessable_entity }
        format.xml { render :xml => @shop_product.errors.to_xml, :status => :unprocessable_entity }
        format.json { render :json => @shop_product.errors.to_json, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/shop/products/1
  # PUT /admin/shop/products/1.js
  # PUT /admin/shop/products/1.xml
  # PUT /admin/shop/products/1.json                               AJAX and HTML
  #----------------------------------------------------------------------------
  def update
    @shop_product = ShopProduct.find(params[:id])
    if @shop_product.update_attributes!(params[:shop_product])
      respond_to do |format|
        format.html { 
          flash[:notice] = "Product updated successfully."
          redirect_to admin_shop_products_path
        }
        format.js { render :partial => '/admin/shop/products/excerpt', :locals => { :excerpt => @shop_product } }
        format.xml { redirect_to "/admin/shop/products/#{@shop_product.id}.xml" }
        format.json { redirect_to "/admin/shop/products/#{@shop_product.id}.json" }
      end
    else
      respond_to do |format|
        format.html {
          flash[:error] = "Unable to update new product."
          render
        }
        format.js { render :text => @shop_product.errors.to_s, :status => 422 }
        format.xml { render :xml => @shop_product.errors.to_xml, :status => 422 }
        format.json { render :json => @shop_product.errors.to_json, :status => 422 }
      end
    end
  end   

  # DELETE /admin/shop/products/1
  # DELETE /admin/shop/products/1.js
  # DELETE /admin/shop/products/1.xml
  # DELETE /admin/shop/products/1.json                            AJAX and HTML
  #----------------------------------------------------------------------------
  def destroy
    # Need to rewrite this method to check for errors and return xml or json.
    # For some reason the answer isn't obvious to me.
    @shop_product = ShopProduct.find(params[:id])
    @shop_product.destroy if @shop_product
    respond_to do |format|      
      format.html { 
        flash[:notice] = "Product deleted successfully."
        redirect_to admin_shop_products_path 
      }
      format.js { render :text => "Product deleted successfully.", :status => 200 }
      format.xml { render :xml => {:message => "Product deleted successfully."}, :status => 200 }
      format.json { render :json => {:message => "Product deleted successfully."}, :status => 200 }
    end
  end   
  
end