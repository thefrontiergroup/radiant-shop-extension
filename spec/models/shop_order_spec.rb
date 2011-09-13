require File.dirname(__FILE__) + "/../spec_helper"

describe ShopOrder do

  dataset :shop_orders, :shop_line_items, :shop_products, :shop_payments

  it { should belong_to :created_by }
  it { should belong_to :updated_by }
  it { should belong_to :customer }

  it { should have_one :billing }
  it { should have_one :shipping }
  it { should have_one :licensing }

  describe '#quantity' do
    it 'should return the total items' do
      shop_orders(:empty).quantity.should         === shop_orders(:empty).line_items.sum(:quantity)
      shop_orders(:several_items).quantity.should === shop_orders(:several_items).line_items.sum(:quantity)
    end
  end

  describe '#weight' do
    it 'should calculate a total weight' do
      shop_orders(:empty).weight.should           === lambda{ weight = 0; shop_orders(:empty).line_items.map { |l| weight += l.weight }; weight }.call
      shop_orders(:several_items).weight.should   === lambda{ weight = 0; shop_orders(:several_items).line_items.map { |l| weight += l.weight }; weight }.call
    end
  end

  describe '#price' do
    context 'inclusive tax' do
      it 'should calculate from the line items alone' do
        Radiant::Config['shop.tax_strategy'] = 'inclusive'

        shop_orders(:empty).price.should            === lambda{ price = 0; shop_orders(:empty).line_items.map { |l| price += l.price }; price }.call
        shop_orders(:several_items).price.should    === lambda{ price = 0; shop_orders(:several_items).line_items.map { |l| price += l.price }; price }.call
      end
    end
    context 'exclusive tax' do
      before do
        Radiant::Config['shop.tax_strategy']   = 'exclusive'
        Radiant::Config['shop.tax_percentage'] = 10
      end

      let(:several_items_price) do
        shop_orders(:several_items).line_items.map(&:price).sum + shop_orders(:several_items).tax
      end

      let(:empty_price) do
        shop_orders(:empty).line_items.map(&:price).sum + shop_orders(:empty).tax
      end

      it 'calculates the correct item price for an empty cart' do
        shop_orders(:empty).price.should === empty_price
      end

      it 'calculates the correct item price for a cart with several items' do
        pending 'Looks like the tax calculations are not being done'
        shop_orders(:several_items).price.should === several_items_price
      end
    end
  end

  describe '#new?' do
    context 'success' do
      it 'should return true' do
        shop_orders(:one_item).update_attribute(:status, 'new')
        shop_orders(:one_item).new?.should === true
      end
    end
    context 'failure' do
      it 'should return false' do
        shop_orders(:one_item).update_attribute(:status, 'paid')
        shop_orders(:one_item).new?.should === false

        shop_orders(:one_item).update_attribute(:status, 'shipped')
        shop_orders(:one_item).new?.should === false
      end
    end
  end
  describe '#shipped?' do
    context 'success' do
      it 'should return true' do
        shop_orders(:one_item).update_attribute(:status, 'shipped')
        shop_orders(:one_item).shipped?.should === true
      end
    end
    context 'failure' do
      it 'should return false' do
        shop_orders(:one_item).update_attribute(:status, 'new')
        shop_orders(:one_item).shipped?.should === false

        shop_orders(:one_item).update_attribute(:status, 'paid')
        shop_orders(:one_item).shipped?.should === false
      end
    end
  end
  describe '#paid?' do
    context 'success' do
      it 'should return true' do
        shop_orders(:several_items).update_attribute(:status, 'paid')

        shop_orders(:several_items).payment.should  === shop_payments(:visa)
        shop_orders(:several_items).paid?.should    === true
      end
    end
    context 'failure' do
      describe 'status is not paid' do
        it 'should return false' do
          shop_orders(:several_items).update_attribute(:status, 'new')
          shop_orders(:several_items).paid?.should === false
        end
      end
      describe 'payment is nil' do
        it 'should return false' do
          shop_orders(:several_items).update_attribute(:status, 'paid')
          shop_orders(:several_items).payment = nil
          shop_orders(:several_items).paid?.should === false
        end
      end
      describe 'payment amount doesnt match' do
        it 'should return false' do
          shop_orders(:several_items).update_attribute(:status, 'paid')
          shop_orders(:several_items).payment.update_attribute(:amount, 11.00)
          shop_orders(:several_items).paid?.should === false
        end
      end
    end
  end

  describe '#add!' do
    context 'item not in cart' do
      before :each do
        @order = shop_orders(:empty)
        @product = shop_products(:crusty_bread)
      end
      context 'no quantity or type passed' do
        it 'should assign a default type and default quantity' do
          @order.add!(@product.id)

          @order.line_items.count.should           === 1
          @order.line_items.first.item_type.should === 'ShopProduct'
          @order.line_items.first.quantity.should  === 1
          @order.line_items.first.item.should      === @product
        end
      end
      context 'quantity passed' do
        it 'should assign the default type and new quantity' do
          @order.add!(@product.id, 2)

          @order.line_items.count.should           === 1
          @order.line_items.first.item_type.should === 'ShopProduct'
          @order.line_items.first.quantity.should  === 2
          @order.line_items.first.item.should      === @product
        end
      end
      context 'type and quantity passed' do
        it 'should assign the new type and new quantity' do
          @order.add!(@product.id, 2, 'ShopProductAlternative')

          @order.line_items.count.should           === 1
          @order.quantity.should                   === 2
          @order.line_items.first.item_type.should === 'ShopProductAlternative'
        end
      end
      it 'calls the line_item_added callback' do
        mock(@order).line_item_added(anything)
        @order.add!(@product.id)
      end
    end
    context 'item in cart' do
      before :each do
        @order      = shop_orders(:one_item)
        @line_item  = @order.line_items.first
      end
      context 'no quantity or type passed' do
        it 'should assign a default type and default quantity' do
          @order.add!(@line_item.id)

          @order.line_items.count.should === 1
          @order.quantity.should         === 1
        end
      end
      context 'quantity passed' do
        it 'should assign the default type and new quantity' do
          @order.add!(@line_item.id, 2)

          @order.line_items.count.should === 1
          @order.quantity.should         === 3
        end
      end
    end
  end
  describe '#modify!' do
    context 'quantity not set' do
      before :each do
        @order = shop_orders(:one_item)
        @line_item = @order.line_items.first
      end
      it 'should not update the item' do
        @order.modify!(@line_item.id)

        @order.quantity.should === 1
      end
    end
    context 'quantity set' do
      before :each do
        @order = shop_orders(:one_item)
        @line_item = @order.line_items.first
      end
      context 'quantity > 0' do
        it 'should assign that quantity' do
          @order.modify!(@line_item.id, 1)
          @order.quantity.should === 1

          @order.modify!(@line_item.id, 2)
          @order.quantity.should === 2

          @order.modify!(@line_item.id, 100)
          @order.quantity.should === 100
        end
      end
      context 'quantity <= 0' do
        it 'should remove that item for 0' do
          @order.modify!(@line_item.id, 0)
          @order.quantity.should === 0
        end
        it 'should remove that item for -1' do
          @order.modify!(@line_item.id, -1)
          @order.quantity.should === 0
        end
        it 'should remove that item for -100' do
          @order.modify!(@line_item.id, -100)
          @order.quantity.should === 0
        end
      end
    end
  end
  describe '#remove!' do
    before { @order = shop_orders(:several_items) }

    it 'should remove the item' do
      items = @order.line_items.count

      @order.remove!(@order.line_items.first.id)
      @order.line_items.count.should === items - 1
    end

    it 'calls the line_item_removed callback' do
      item = @order.line_items.first

      mock(@order).line_item_removed(item)
      @order.remove!(item.id)
    end
  end
  describe '#clear!' do
    it 'should remove all items' do
      @order = shop_orders(:several_items)
      @order.clear!
      @order.quantity.should === 0
    end
  end

  describe '.scope_by_status' do
    context 'no scoping' do
      before :each do
        @orders = ShopOrder.count
      end
      context 'nil' do
        it 'should return all' do
          ShopOrder.scope_by_status(nil) do
            ShopOrder.count.should === @orders
          end
        end
      end
      context 'blank' do
        it 'should return all' do
          ShopOrder.scope_by_status('') do
            ShopOrder.count.should === @orders
          end
        end
      end
      context 'missing' do
        it 'should return all' do
          ShopOrder.scope_by_status('this_status_shall_never_be_real') do
            ShopOrder.count.should === @orders
          end
        end
      end
    end
    context 'scoping' do
      before :each do
        ShopOrder.create(:status => 'new')
        ShopOrder.create(:status => 'shipped')
        ShopOrder.create(:status => 'paid')
      end
      context 'new' do
        it 'should return matching count' do
          @orders = ShopOrder.all(:conditions => { :status => 'new' }).count
          ShopOrder.scope_by_status('new') do
            ShopOrder.count.should === @orders
          end
        end
      end
      context 'shipped' do
        it 'should return matching count' do
          @orders = ShopOrder.all(:conditions => { :status => 'shipped' }).count
          ShopOrder.scope_by_status('shipped') do
            ShopOrder.count.should === @orders
          end
        end
      end
      context 'paid' do
        it 'should return matching count' do
          @orders = ShopOrder.all(:conditions => { :status => 'paid' }).count
          ShopOrder.scope_by_status('paid') do
            ShopOrder.count.should === @orders
          end
        end
      end
    end
  end

  describe '.params' do
    it 'should have a set of standard parameters' do
      ShopOrder.params.should === [ :id, :notes, :status ]
    end
  end

end
