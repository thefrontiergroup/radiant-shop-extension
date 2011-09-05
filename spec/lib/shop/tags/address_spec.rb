require File.dirname(__FILE__) + '/../../../spec_helper'

address_types = %w(billing shipping licensing)

#
# Tests for shop address tags
#
describe Shop::Tags::Address do

  dataset :pages, :shop_addresses, :shop_orders

  let(:tags)          { %w(id login name phone email business unit
      street_1 street_2 city state country postcode) }
  let(:all_tags) do
    all_tags = address_types.map { |type| "shop:cart:#{type}" }
    all_tags += address_types.map { |type| tags.map { |tag| "shop:cart:#{type}:#{tag}" } }
    all_tags += address_types.map { |type| "shop:cart:#{type}:if_#{type}" }
    all_tags += address_types.map { |type| "shop:cart:#{type}:unless_#{type}" }
    all_tags.flatten
  end

  it 'should describe these tags' do
    Shop::Tags::Address.tags.should =~ all_tags
  end

  address_types.each do |address_type|

    context "inside cart (#{address_type})" do

      before :all do
        @page = pages(:home)
      end

      before :each do
        @order = shop_orders(:several_items)
        @address = send(:"shop_#{address_type}s", :"order_#{address_type}")
        stub(Shop::Tags::Helpers).current_order(anything) { @order }
        UserActionObserver.current_user = @order.customer
      end

      describe "shop:cart:#{address_type}:#{address_type}" do
        context 'success' do
          it 'should expand' do
            tag = %{<r:shop:cart:#{address_type}:if_#{address_type}>success</r:shop:cart:#{address_type}:if_#{address_type}>}
            exp = %{success}

            @page.should render(tag).as(exp)
          end
        end
        context 'failure' do
          before :each do
            mock(@order, address_type)
          end
          it 'should not expand' do
            tag = %{<r:shop:cart:#{address_type}:if_#{address_type}>failure</r:shop:cart:#{address_type}:if_#{address_type}>}
            exp = %{}

            @page.should render(tag).as(exp)
          end
        end
      end

      describe "shop:cart:#{address_type}:unless_#{address_type}" do
        context 'success' do
          before :each do
            mock(@order, address_type)
          end
          it 'should expand' do
            tag = %{<r:shop:cart:#{address_type}:unless_#{address_type}>success</r:shop:cart:#{address_type}:unless_#{address_type}>}
            exp = %{success}

            @page.should render(tag).as(exp)
          end
        end
        context 'failure' do
          it 'should not expand' do
            tag = %{<r:shop:cart:#{address_type}:unless_#{address_type}>failure</r:shop:cart:#{address_type}:unless_#{address_type}>}
            exp = %{}

            @page.should render(tag).as(exp)
          end
        end
      end

      describe "shop:#{address_type}" do
        context "#{address_type} doesnt exist" do
          before :each do
            mock(@order, address_type)
          end
          it 'should expand' do
            tag = %{<r:shop:cart:#{address_type}>success</r:shop:cart:#{address_type}>}
            exp = %{success}

            @page.should render(tag).as(exp)
          end
        end
        context "#{address_type} exists" do
          it 'should expand' do
            tag = %{<r:shop:cart:#{address_type}>success</r:shop:cart:#{address_type}>}
            exp = %{success}

            @page.should render(tag).as(exp)
          end
        end
      end

      describe 'attributes' do
        context "shop:cart:#{address_type}:login" do
          it 'should return the login of the customer' do
            tag = %{<r:shop:cart:#{address_type}><r:login /></r:shop:cart:#{address_type}>}
            exp = @order.customer.login

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:id" do
          it 'should return the id' do
            tag = %{<r:shop:cart:#{address_type}><r:id /></r:shop:cart:#{address_type}>}
            exp = @address.id.to_s

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:name" do
          it 'should return the name' do
            tag = %{<r:shop:cart:#{address_type}><r:name /></r:shop:cart:#{address_type}>}
            exp = @address.name

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:phone" do
          it 'should return the phone' do
            tag = %{<r:shop:cart:#{address_type}><r:phone /></r:shop:cart:#{address_type}>}
            exp = @address.phone

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:business" do
          it 'should return the email' do
            tag = %{<r:shop:cart:#{address_type}><r:business /></r:shop:cart:#{address_type}>}
            exp = @address.business

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:email" do
          it 'should return the email' do
            tag = %{<r:shop:cart:#{address_type}><r:email /></r:shop:cart:#{address_type}>}
            exp = @address.email

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:unit" do
          it 'should return the unit' do
            tag = %{<r:shop:cart:#{address_type}><r:unit /></r:shop:cart:#{address_type}>}
            exp = @address.unit

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:street_1" do
          it 'should return the street' do
            tag = %{<r:shop:cart:#{address_type}><r:street_1 /></r:shop:cart:#{address_type}>}
            exp = @address.street_1

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:street_2" do
          it 'should return the street' do
            tag = %{<r:shop:cart:#{address_type}><r:street_2 /></r:shop:cart:#{address_type}>}
            exp = @address.street_2

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:city" do
          it 'should return the city' do
            tag = %{<r:shop:cart:#{address_type}><r:city /></r:shop:cart:#{address_type}>}
            exp = @address.city

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:state" do
          it 'should return the city' do
            tag = %{<r:shop:cart:#{address_type}><r:state /></r:shop:cart:#{address_type}>}
            exp = @address.state

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:country" do
          it 'should return the country' do
            tag = %{<r:shop:cart:#{address_type}><r:country /></r:shop:cart:#{address_type}>}
            exp = @address.country

            @page.should render(tag).as(exp)
          end
        end
        context "shop:cart:#{address_type}:postcode" do
          it 'should return the postcode' do
            tag = %{<r:shop:cart:#{address_type}><r:postcode /></r:shop:cart:#{address_type}>}
            exp = @address.postcode

            @page.should render(tag).as(exp)
          end
        end
      end
    end
  end
end
