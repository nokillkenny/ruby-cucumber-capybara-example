class BasePage
  include Capybara::DSL
  include RSpec::Matchers

  WAIT_TIMEOUT = 10

  def visit_path(path)
    visit path
  end
end
