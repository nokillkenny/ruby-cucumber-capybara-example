require_relative '../support/pages/forms_page'

forms_page = FormsPage.new

Given('I am on the checkboxes page') do
  forms_page.visit_checkboxes
  @initial_state = forms_page.first_checkbox_checked?
end

Given('I am on the dropdown page') do
  forms_page.visit_dropdown
end

When('I toggle the first checkbox') do
  forms_page.toggle_first_checkbox
end

Then('the first checkbox state changes') do
  expect(forms_page.first_checkbox_checked?).not_to eq(@initial_state)
end

When('I select {string} from the dropdown') do |option|
  forms_page.select_option(option)
end

Then('{string} is selected') do |option|
  expect(forms_page.selected_option).to eq('1') if option == 'Option 1'
  expect(forms_page.selected_option).to eq('2') if option == 'Option 2'
end
