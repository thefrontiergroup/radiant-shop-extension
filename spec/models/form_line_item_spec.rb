require 'spec_helper'

describe FormLineItem do

  dataset :shop_orders, :shop_products, :pages

  describe '#create' do

    let(:order)       { shop_orders(:empty) }
    let(:product_one) { shop_products(:choc_milk) }
    let(:product_two) { shop_products(:hilo_milk) }
    let(:page)        { pages(:home) }
    let(:config)      { { } }
    let(:data)        { { } }

    before :each do
      stub(page).data                  { data }
      stub(page).request.stub!.session { { :shop_order => order.id } }
    end

    subject { FormLineItem.new(nil, page, config) }

    context 'when the process is add' do

      let(:config) { { :process => 'add' } }

      context 'for a single line item' do

        let(:data) { { :line_item => { :item_id => product_one.id, :item_type => product_one.class.to_s, :quantity => 3 } } }

        it 'should add the line item to the current order' do
          order.line_items.should be_empty
          subject.create
          order.reload.line_items.should be_present
        end

        it 'should assign the correct item to the line item' do
          subject.create
          order.reload.line_items.last.item.should == product_one
        end

        it 'should set the corrrect quantity for the line item' do
          subject.create
          order.reload.line_items.last.quantity.should == 3
        end

      end

      context 'for multiple line items' do

        let(:line_item_data_one) { { :item_id => product_one.id, :item_type => product_one.class.to_s, :quantity => 5 } }
        let(:line_item_data_two) { { :item_id => product_two.id, :item_type => product_two.class.to_s, :quantity => 8 } }
        let(:data)               { { :line_items => { '0' => line_item_data_one, '1' => line_item_data_two  } } }

        it 'should add all of the line items to the current order' do
          order.line_items.should be_empty
          subject.create
          order.reload.line_items.size.should == 2
        end

        it 'should assign the correct item to each line item' do
          subject.create
          items = order.reload.line_items.sort_by(&:item_id)
          items.first.item.should  == product_two
          items.last.item.should == product_one
        end

        it 'should set the corrrect quantity for each line item' do
          subject.create
          items = order.reload.line_items.sort_by(&:item_id)
          items.first.quantity.should == 8
          items.last.quantity.should == 5
        end

      end

    end

  end

end
