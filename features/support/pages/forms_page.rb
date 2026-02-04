require_relative 'base_page'

class FormsPage < BasePage
  CHECKBOX_1 = 'input[type="checkbox"]:first-of-type'
  DROPDOWN = '#dropdown'

  def visit_checkboxes
    visit_path '/checkboxes'
  end

  def visit_dropdown
    visit_path '/dropdown'
  end

  def toggle_first_checkbox
    page.all('input[type="checkbox"]').first.click
  end

  def first_checkbox_checked?
    page.all('input[type="checkbox"]').first.checked?
  end

  def select_option(option)
    find(DROPDOWN).select(option)
  end

  def selected_option
    find(DROPDOWN).value
  end
end
