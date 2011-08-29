require File.dirname(__FILE__) + "/../spec_helper"

shared_examples_for 'an admin is logged in' do

  before do
    User.create!(:name => 'Kevin Rudd', :login => 'kevin07', :password => 'france', :password_confirmation => 'france', :admin => true)

    visit "/admin/login"
    fill_in "Username or E-mail Address", :with => 'kevin07'
    fill_in "Password", :with => 'france'
    click_button "Login"
  end

  after do
    visit "/admin/logout"
  end

end

describe 'Administrators impersonating customers' do

  context 'when assuming a customers identity' do

    it_should_behave_like 'an admin is logged in'

    let!(:customer) { ShopCustomer.create!(:name => 'Julia Gillard', :login => 'rouge1', :password => 'carbontax', :password_confirmation => 'carbontax') }

    before do
      click_link "Shop"
      click_link "Customers"
    end

    it 'has a link to allow the admin to assume a customers identity' do
      page.should have_content('Assume Identity')
    end

    context 'when the customers identity has been assumed' do
      before do
        click_link "Assume Identity"
      end

      it 'redirects to the home page' do
        current_path.should == '/'
      end

      it 'impersonating_user? returns true' do

      end

      it 'current_user returns the new users identity'


      it 'displays the new users identity in the login name display'

    end

  end

end
