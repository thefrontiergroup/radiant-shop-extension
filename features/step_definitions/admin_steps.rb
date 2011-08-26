Given /^the admin user "([^"]*)" exists$/ do |user_full_name|
  @password = 'irflctd'
  User.create!(:name => user_full_name, :login => 'login', :password => @password, :password_confirmation => @password)
end

Given /^I am logged in as the user "([^"]*)"$/ do |user_full_name|
  user = User.find_by_name(user_full_name)
  Given %{I am on the login page}
  When %{I fill in "Username" with #{user.login}}
  When %{I fill in "Password" with #{@password}}
  When %{I press "login" within "#login_form"}
end

Given /^I am assuming the identity of "([^"]*)"$/ do |customer_full_name|
  pending # express the regexp above with the code you wish you had
end

When /^I follow the return to original identity button on the page$/ do
  pending # express the regexp above with the code you wish you had
end
