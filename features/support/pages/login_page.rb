require_relative 'base_page'

class LoginPage < BasePage
  USERNAME_FIELD = '#username'
  PASSWORD_FIELD = '#password'
  LOGIN_BUTTON = 'button[type="submit"]'
  FLASH_MESSAGE = '#flash'
  SECURE_AREA = '.example h2'

  VALID_USER = ENV['TEST_USER']
  VALID_PASS = ENV['TEST_PASS']

  def visit_page
    visit_path '/login'
  end

  def enter_credentials(username, password)
    find(USERNAME_FIELD).set(username)
    find(PASSWORD_FIELD).set(password)
  end

  def enter_valid_credentials
    enter_credentials(VALID_USER, VALID_PASS)
  end

  def enter_invalid_credentials
    enter_credentials('invalid', 'invalid')
  end

  def submit
    find(LOGIN_BUTTON).click
  end

  def assert_secure_area_visible
    expect(page).to have_current_path('/secure', wait: WAIT_TIMEOUT)
    expect(page).to have_css(SECURE_AREA, text: 'Secure Area')
  end

  def assert_error_visible
    expect(page).to have_css(FLASH_MESSAGE, text: 'invalid', wait: WAIT_TIMEOUT)
  end
end
