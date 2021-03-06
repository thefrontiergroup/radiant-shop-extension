require File.dirname(__FILE__) + "/../spec_helper"

describe ShopBilling do

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:business) }

  describe 'scope' do
    let(:billing) { ShopBilling.new }

    it 'should have a of_type of billing' do
      billing.of_type.should == 'billing'
    end
  end

end
