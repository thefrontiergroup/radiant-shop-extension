# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-shop-extension}
  s.version = "0.94.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dirk Kelly", "John Barker", "Darcy Laycock"]
  s.date = %q{2011-04-05}
  s.description = %q{Radiant Shop is an attempt at a simple but complete store. It includes Products, Categories, Orders and Credit Card Payments}
  s.email = %q{dk@dirkkelly.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "HISTORY.md",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/.DS_Store",
    "app/controllers/admin/shop/categories_controller.rb",
    "app/controllers/admin/shop/customers_controller.rb",
    "app/controllers/admin/shop/orders_controller.rb",
    "app/controllers/admin/shop/products/images_controller.rb",
    "app/controllers/admin/shop/products_controller.rb",
    "app/controllers/admin/shops_controller.rb",
    "app/helpers/shop_helper.rb",
    "app/models/form_address.rb",
    "app/models/form_checkout.rb",
    "app/models/form_line_item.rb",
    "app/models/shop_address.rb",
    "app/models/shop_billing.rb",
    "app/models/shop_category.rb",
    "app/models/shop_category_page.rb",
    "app/models/shop_customer.rb",
    "app/models/shop_line_item.rb",
    "app/models/shop_order.rb",
    "app/models/shop_page.rb",
    "app/models/shop_payment.rb",
    "app/models/shop_product.rb",
    "app/models/shop_product_page.rb",
    "app/models/shop_shipping.rb",
    "app/views/.DS_Store",
    "app/views/admin/.DS_Store",
    "app/views/admin/shop/categories/edit.html.haml",
    "app/views/admin/shop/categories/edit/_foot.html.haml",
    "app/views/admin/shop/categories/edit/_form.html.haml",
    "app/views/admin/shop/categories/edit/_head.html.haml",
    "app/views/admin/shop/categories/edit/_inputs.html.haml",
    "app/views/admin/shop/categories/edit/_meta.html.haml",
    "app/views/admin/shop/categories/edit/_parts.html.haml",
    "app/views/admin/shop/categories/edit/_popups.html.haml",
    "app/views/admin/shop/categories/edit/inputs/_name.html.haml",
    "app/views/admin/shop/categories/edit/meta/_handle.html.haml",
    "app/views/admin/shop/categories/edit/meta/_layouts.html.haml",
    "app/views/admin/shop/categories/edit/meta/_page.html.haml",
    "app/views/admin/shop/categories/edit/meta/_status.html.haml",
    "app/views/admin/shop/categories/edit/parts/_description.html.haml",
    "app/views/admin/shop/categories/index/_category.html.haml",
    "app/views/admin/shop/categories/new.html.haml",
    "app/views/admin/shop/categories/remove.html.haml",
    "app/views/admin/shop/customers/edit.html.haml",
    "app/views/admin/shop/customers/edit/_foot.html.haml",
    "app/views/admin/shop/customers/edit/_form.html.haml",
    "app/views/admin/shop/customers/edit/_head.html.haml",
    "app/views/admin/shop/customers/edit/_inputs.html.haml",
    "app/views/admin/shop/customers/edit/_meta.html.haml",
    "app/views/admin/shop/customers/edit/_parts.html.haml",
    "app/views/admin/shop/customers/edit/_popups.html.haml",
    "app/views/admin/shop/customers/edit/inputs/_email.html.haml",
    "app/views/admin/shop/customers/edit/inputs/_name.html.haml",
    "app/views/admin/shop/customers/edit/meta/_login.html.haml",
    "app/views/admin/shop/customers/edit/meta/_password.html.haml",
    "app/views/admin/shop/customers/edit/meta/_password_confirmation.html.haml",
    "app/views/admin/shop/customers/edit/parts/_address.html.haml",
    "app/views/admin/shop/customers/edit/parts/_addresses.html.haml",
    "app/views/admin/shop/customers/edit/parts/_orders.html.haml",
    "app/views/admin/shop/customers/index.html.haml",
    "app/views/admin/shop/customers/index/_customer.html.haml",
    "app/views/admin/shop/customers/index/_foot.html.haml",
    "app/views/admin/shop/customers/index/_head.html.haml",
    "app/views/admin/shop/customers/new.html.haml",
    "app/views/admin/shop/customers/remove.html.haml",
    "app/views/admin/shop/orders/edit.html.haml",
    "app/views/admin/shop/orders/edit/_foot.html.haml",
    "app/views/admin/shop/orders/edit/_form.html.haml",
    "app/views/admin/shop/orders/edit/_head.html.haml",
    "app/views/admin/shop/orders/edit/_inputs.html.haml",
    "app/views/admin/shop/orders/edit/_meta.html.haml",
    "app/views/admin/shop/orders/edit/_parts.html.haml",
    "app/views/admin/shop/orders/edit/_popups.html.haml",
    "app/views/admin/shop/orders/edit/parts/_address.html.haml",
    "app/views/admin/shop/orders/edit/parts/_addresses.html.haml",
    "app/views/admin/shop/orders/edit/parts/_customer.html.haml",
    "app/views/admin/shop/orders/edit/parts/_items.html.haml",
    "app/views/admin/shop/orders/index.html.haml",
    "app/views/admin/shop/orders/index/_foot.html.haml",
    "app/views/admin/shop/orders/index/_head.html.haml",
    "app/views/admin/shop/orders/index/_order.html.haml",
    "app/views/admin/shop/orders/index/buttons/_all.html.haml",
    "app/views/admin/shop/orders/index/buttons/_new.html.haml",
    "app/views/admin/shop/orders/index/buttons/_paid.html.haml",
    "app/views/admin/shop/orders/index/buttons/_shipped.html.haml",
    "app/views/admin/shop/products/edit.html.haml",
    "app/views/admin/shop/products/edit/_foot.html.haml",
    "app/views/admin/shop/products/edit/_form.html.haml",
    "app/views/admin/shop/products/edit/_head.html.haml",
    "app/views/admin/shop/products/edit/_inputs.html.haml",
    "app/views/admin/shop/products/edit/_meta.html.haml",
    "app/views/admin/shop/products/edit/_parts.html.haml",
    "app/views/admin/shop/products/edit/_popups.html.haml",
    "app/views/admin/shop/products/edit/buttons/_browse_images.html.haml",
    "app/views/admin/shop/products/edit/buttons/_new_image.html.haml",
    "app/views/admin/shop/products/edit/inputs/_name.html.haml",
    "app/views/admin/shop/products/edit/inputs/_price.html.haml",
    "app/views/admin/shop/products/edit/meta/_category.html.haml",
    "app/views/admin/shop/products/edit/meta/_layout.html.haml",
    "app/views/admin/shop/products/edit/meta/_page.html.haml",
    "app/views/admin/shop/products/edit/meta/_sku.html.haml",
    "app/views/admin/shop/products/edit/meta/_status.html.haml",
    "app/views/admin/shop/products/edit/parts/_customers.html.haml",
    "app/views/admin/shop/products/edit/parts/_description.html.haml",
    "app/views/admin/shop/products/edit/parts/_images.html.haml",
    "app/views/admin/shop/products/edit/popups/_browse_images.html.haml",
    "app/views/admin/shop/products/edit/popups/_new_image.html.haml",
    "app/views/admin/shop/products/edit/shared/_image.html.haml",
    "app/views/admin/shop/products/index.html.haml",
    "app/views/admin/shop/products/index/_foot.html.haml",
    "app/views/admin/shop/products/index/_head.html.haml",
    "app/views/admin/shop/products/index/_product.html.haml",
    "app/views/admin/shop/products/index/buttons/_add_category.html.haml",
    "app/views/admin/shop/products/new.html.haml",
    "app/views/admin/shop/products/remove.html.haml",
    "config/locales/en.yml",
    "config/routes.rb",
    "db/migrate/20101011063133_setup_shop.rb",
    "db/migrate/20101208045754_address_changes.rb",
    "db/migrate/20101208121105_move_to_page_attachments.rb",
    "db/migrate/20101214023052_fix_addressable_column_type.rb",
    "db/migrate/20110119095350_add_position_to_shop_category.rb",
    "db/migrate/20110330042956_add_company_to_address.rb",
    "db/seed.rb",
    "db/seeds/forms.rb",
    "db/seeds/layouts.rb",
    "db/seeds/pages.rb",
    "db/seeds/products.rb",
    "db/seeds/snippets.rb",
    "lib/radiant-shop-extension.rb",
    "lib/shop/controllers/application_controller.rb",
    "lib/shop/controllers/site_controller.rb",
    "lib/shop/interface/categories.rb",
    "lib/shop/interface/customers.rb",
    "lib/shop/interface/discounts.rb",
    "lib/shop/interface/orders.rb",
    "lib/shop/interface/products.rb",
    "lib/shop/models/form_extension.rb",
    "lib/shop/models/page.rb",
    "lib/shop/models/user.rb",
    "lib/shop/tags/address.rb",
    "lib/shop/tags/card.rb",
    "lib/shop/tags/cart.rb",
    "lib/shop/tags/category.rb",
    "lib/shop/tags/core.rb",
    "lib/shop/tags/helpers.rb",
    "lib/shop/tags/item.rb",
    "lib/shop/tags/product.rb",
    "lib/shop/tags/tax.rb",
    "lib/tasks/shop_extension_tasks.rake",
    "public/images/admin/extensions/shop/products/sort.png",
    "public/javascripts/admin/extensions/shop/edit.js",
    "public/javascripts/admin/extensions/shop/products/edit.js",
    "public/javascripts/admin/extensions/shop/products/index.js",
    "public/stylesheets/sass/admin/extensions/shop/edit.sass",
    "public/stylesheets/sass/admin/extensions/shop/index.sass",
    "public/stylesheets/sass/admin/extensions/shop/products/edit.sass",
    "public/stylesheets/sass/admin/extensions/shop/products/index.sass",
    "radiant-shop-extension.gemspec",
    "shop_extension.rb",
    "spec/controllers/admin/shop/categories_controller_spec.rb",
    "spec/controllers/admin/shop/customers_controller_spec.rb",
    "spec/controllers/admin/shop/orders_controller_spec.rb",
    "spec/controllers/admin/shop/products/images_controller_spec.rb",
    "spec/controllers/admin/shop/products_controller_spec.rb",
    "spec/controllers/admin/shops_controller_spec.rb",
    "spec/datasets/forms.rb",
    "spec/datasets/shop_addresses.rb",
    "spec/datasets/shop_attachments.rb",
    "spec/datasets/shop_categories.rb",
    "spec/datasets/shop_config.rb",
    "spec/datasets/shop_customers.rb",
    "spec/datasets/shop_line_items.rb",
    "spec/datasets/shop_orders.rb",
    "spec/datasets/shop_payments.rb",
    "spec/datasets/shop_products.rb",
    "spec/datasets/tags.rb",
    "spec/helpers/nested_tag_helper.rb",
    "spec/lib/shop/models/page_spec.rb",
    "spec/lib/shop/tags/address_spec.rb",
    "spec/lib/shop/tags/card_spec.rb",
    "spec/lib/shop/tags/cart_spec.rb",
    "spec/lib/shop/tags/category_spec.rb",
    "spec/lib/shop/tags/core_spec.rb",
    "spec/lib/shop/tags/helpers_spec.rb",
    "spec/lib/shop/tags/item_spec.rb",
    "spec/lib/shop/tags/product_spec.rb",
    "spec/lib/shop/tags/tax_spec.rb",
    "spec/matchers/comparison.rb",
    "spec/matchers/render_matcher.rb",
    "spec/models/form_address_spec.rb",
    "spec/models/form_checkout_spec.rb",
    "spec/models/shop_address_spec.rb",
    "spec/models/shop_billing_spec.rb",
    "spec/models/shop_category_page_spec.rb",
    "spec/models/shop_category_spec.rb",
    "spec/models/shop_customer_spec.rb",
    "spec/models/shop_line_item_spec.rb",
    "spec/models/shop_order_spec.rb",
    "spec/models/shop_payment_spec.rb",
    "spec/models/shop_product_page_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/models/shop_shipping_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/squaretalent/radiant-shop-extension}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.3}
  s.summary = %q{Shop Extension for Radiant CMS}
  s.test_files = [
    "spec/controllers/admin/shop/categories_controller_spec.rb",
    "spec/controllers/admin/shop/customers_controller_spec.rb",
    "spec/controllers/admin/shop/orders_controller_spec.rb",
    "spec/controllers/admin/shop/products/images_controller_spec.rb",
    "spec/controllers/admin/shop/products_controller_spec.rb",
    "spec/controllers/admin/shops_controller_spec.rb",
    "spec/datasets/forms.rb",
    "spec/datasets/shop_addresses.rb",
    "spec/datasets/shop_attachments.rb",
    "spec/datasets/shop_categories.rb",
    "spec/datasets/shop_config.rb",
    "spec/datasets/shop_customers.rb",
    "spec/datasets/shop_line_items.rb",
    "spec/datasets/shop_orders.rb",
    "spec/datasets/shop_payments.rb",
    "spec/datasets/shop_products.rb",
    "spec/datasets/tags.rb",
    "spec/helpers/nested_tag_helper.rb",
    "spec/lib/shop/models/page_spec.rb",
    "spec/lib/shop/tags/address_spec.rb",
    "spec/lib/shop/tags/card_spec.rb",
    "spec/lib/shop/tags/cart_spec.rb",
    "spec/lib/shop/tags/category_spec.rb",
    "spec/lib/shop/tags/core_spec.rb",
    "spec/lib/shop/tags/helpers_spec.rb",
    "spec/lib/shop/tags/item_spec.rb",
    "spec/lib/shop/tags/product_spec.rb",
    "spec/lib/shop/tags/tax_spec.rb",
    "spec/matchers/comparison.rb",
    "spec/matchers/render_matcher.rb",
    "spec/models/form_address_spec.rb",
    "spec/models/form_checkout_spec.rb",
    "spec/models/shop_address_spec.rb",
    "spec/models/shop_billing_spec.rb",
    "spec/models/shop_category_page_spec.rb",
    "spec/models/shop_category_spec.rb",
    "spec/models/shop_customer_spec.rb",
    "spec/models/shop_line_item_spec.rb",
    "spec/models/shop_order_spec.rb",
    "spec/models/shop_payment_spec.rb",
    "spec/models/shop_product_page_spec.rb",
    "spec/models/shop_product_spec.rb",
    "spec/models/shop_shipping_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<radiant>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<activemerchant>, [">= 1.8.0"])
      s.add_runtime_dependency(%q<fastercsv>, [">= 1.5.3"])
      s.add_runtime_dependency(%q<acts_as_list>, [">= 0.1.2"])
      s.add_runtime_dependency(%q<radiant-settings-extension>, [">= 1.1.1"])
      s.add_runtime_dependency(%q<radiant-images-extension>, [">= 0.5.0"])
      s.add_runtime_dependency(%q<radiant-forms-extension>, [">= 3.2.6"])
      s.add_runtime_dependency(%q<radiant-users-extension>, [">= 0.0.2"])
      s.add_runtime_dependency(%q<radiant-drag_order-extension>, [">= 0.3.9"])
    else
      s.add_dependency(%q<radiant>, [">= 0.9.1"])
      s.add_dependency(%q<activemerchant>, [">= 1.8.0"])
      s.add_dependency(%q<fastercsv>, [">= 1.5.3"])
      s.add_dependency(%q<acts_as_list>, [">= 0.1.2"])
      s.add_dependency(%q<radiant-settings-extension>, [">= 1.1.1"])
      s.add_dependency(%q<radiant-images-extension>, [">= 0.5.0"])
      s.add_dependency(%q<radiant-forms-extension>, [">= 3.2.6"])
      s.add_dependency(%q<radiant-users-extension>, [">= 0.0.2"])
      s.add_dependency(%q<radiant-drag_order-extension>, [">= 0.3.9"])
    end
  else
    s.add_dependency(%q<radiant>, [">= 0.9.1"])
    s.add_dependency(%q<activemerchant>, [">= 1.8.0"])
    s.add_dependency(%q<fastercsv>, [">= 1.5.3"])
    s.add_dependency(%q<acts_as_list>, [">= 0.1.2"])
    s.add_dependency(%q<radiant-settings-extension>, [">= 1.1.1"])
    s.add_dependency(%q<radiant-images-extension>, [">= 0.5.0"])
    s.add_dependency(%q<radiant-forms-extension>, [">= 3.2.6"])
    s.add_dependency(%q<radiant-users-extension>, [">= 0.0.2"])
    s.add_dependency(%q<radiant-drag_order-extension>, [">= 0.3.9"])
  end
end

