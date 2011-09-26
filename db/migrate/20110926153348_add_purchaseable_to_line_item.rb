class AddPurchaseableToLineItem < ActiveRecord::Migration
  def self.up
    add_column :shop_line_items, :purchaseable, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :shop_line_items, :purchaseable
  end
end
