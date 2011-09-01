require File.dirname(__FILE__) + "/../spec_helper"

shared_examples_for 'an admin is logged in' do

  before do
    User.create!(:name => 'Kevin Rudd', :login => 'kevin07', :password => 'france', :password_confirmation => 'france', :admin => true)

    visit "/admin/login"
    fill_in "Username", :with => 'kevin07'
    fill_in "Password", :with => 'france'
    click_button "login"
  end

  after do
    visit "/admin/logout"
  end

end

describe 'Administrators impersonating customers' do

  context 'when assuming a customers identity' do

    it_should_behave_like 'an admin is logged in'

    let!(:customer)  { ShopCustomer.create!(:name => 'Julia Gillard', :login => 'rouge1', :password => 'carbontax', :password_confirmation => 'carbontax') }
    let!(:home_page) { Page.find_by_slug('/') }

    # The root category is required by the mg_shop plugin
    let!(:root_page) { Page.create!(:slug => 'agrimaster', :title => 'Agrimaster', :breadcrumb => 'Multigrain') }
    let!(:part)      { home_page.parts.first }

    before do
      home_page.update_attributes(:class_name => 'ShopPage', :published_at => Time.now - 1.hour)
      part.update_attributes(:content => <<-eof)
<r:user>
  <r:if_user>
  Logged in as <r:name />
  <r:if_impersonating>
    Wearing a disguise
    <a href="/admin/shop/customers/remove_impersonation">Remove Disguise</a>
  </r:if_impersonating>
  </r:if_user>
</r:user>
      eof

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

      it 'displays the new users identity in the login name display' do
        page.should have_content('Logged in as Julia Gillard')
      end

      it 'displays an indicator that the user is impersonating another' do
        page.should have_content('Wearing a disguise')
      end

    end

    context 'when returning to the former identity' do
      before do
        click_link "Assume Identity"
        click_link 'Remove Disguise'
      end

      it 'redirects be on the admin shop customers page' do
        current_path.should == '/admin/shop/customers'
      end

      it 'displays the former users identity in the login name display' do
        page.should have_content('Logged in as Kevin Rudd')
      end

    end

  end

end
