require_relative '../support/pages/dynamic_page'

dynamic_page = DynamicPage.new

Given('I am on the dynamic loading page') do
  dynamic_page.visit_page
end

When('I click start') do
  dynamic_page.click_start
end

Then('I see {string} after loading') do |expected_text|
  expect(dynamic_page.loaded_text).to eq(expected_text)
end
