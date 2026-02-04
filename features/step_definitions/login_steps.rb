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
  expect(login_page.secure_area_visible?).to be true
end

Then('I see an error message') do
  expect(login_page.error_visible?).to be true
end
