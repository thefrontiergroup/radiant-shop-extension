require File.dirname(__FILE__) + "/../spec_helper"

describe ShopAddress do

  it { should validate_presence_of :name }
  it { should validate_presence_of :street_1 }
  it { should validate_presence_of :city }
  it { should validate_presence_of :postcode }
  it { should validate_presence_of :state }
  it { should validate_presence_of :country }

end
