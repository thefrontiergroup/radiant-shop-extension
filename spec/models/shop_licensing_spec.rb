require File.dirname(__FILE__) + "/../spec_helper"

describe ShopLicensing do

  it { should validate_presence_of(:email) }

  describe 'scope' do
    let(:licensing) { ShopLicensing.new }

    it 'should have a of_type of licensing' do
      licensing.of_type.should == 'licensing'
    end
  end

end
