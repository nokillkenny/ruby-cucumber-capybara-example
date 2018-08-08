class MainPage
  include Capybara::DSL
  include RSpec::Matchers

  DISABLED_INPUT_FIELD ||= '.searchInputNode #search-box-input[disabled=""]'
  CITY_SEARCH_FIELD ||= '.searchInputNode #search-box-input'
  EMAIL_SIGN_IN_BUTTON ||= '.emailSignInButton'
  SUBMIT_EMAIL_BUTTON ||= '.submitButton'
  LOGIN_STATUS ||= '.header-right'
  LIST_OF_LOCATIONS ||= '.expanded-row-content'
  SUGGESTED_CITY ||= '.item-row.clickable'

  USERNAME ||= 'klin@mailinator.com'
  PASSWORD ||= 'Tester123'

  def wait_for_main_to_load
    has_no_css?(DISABLED_INPUT_FIELD)
  end

  def click_login
    find_button('Log In').click
  end

  def login_to_email
    find(EMAIL_SIGN_IN_BUTTON).click

    fill_in('Email', with: USERNAME)
    fill_in('Password', with: PASSWORD)
    find(SUBMIT_EMAIL_BUTTON).click
  end

  def validate_logged_in
    expect(page).to have_css(LOGIN_STATUS, text: 'Tester')
  end

  def search_for_city(name)
    find(CITY_SEARCH_FIELD).set('')
    find(CITY_SEARCH_FIELD).send_keys(name)
  end

  def click_listed_city
    find(LIST_OF_LOCATIONS, text: 'PLACES')  #to wait for load
    find(SUGGESTED_CITY, text: 'Newport Beach', match: :first).click
  end
end