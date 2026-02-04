require_relative 'base_page'

class DynamicPage < BasePage
  START_BUTTON = '#start button'
  LOADED_TEXT = '#finish h4'

  def visit_page
    visit_path '/dynamic_loading/1'
  end

  def click_start
    find(START_BUTTON).click
  end

  def loaded_text
    find(LOADED_TEXT, wait: 10).text
  end
end
