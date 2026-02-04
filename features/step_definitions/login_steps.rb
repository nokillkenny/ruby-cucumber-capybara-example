require_relative '../support/pages/login_page'

login_page = LoginPage.new

Given('I am on the login page') do
  login_page.visit_page
end

When('I enter valid credentials') do
  login_page.enter_valid_credentials
end

When('I enter invalid credentials') do
  login_page.enter_invalid_credentials
end

When('I submit the login form') do
  login_page.submit
end

Then('I see the secure area') do
  login_page.assert_secure_area_visible
end

Then('I see an error message') do
  login_page.assert_error_visible
end
