require 'dotenv'
Dotenv.load('.env.local', '.env')

require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/rspec'

Capybara.default_driver = :selenium_chrome_headless
Capybara.default_max_wait_time = 10
Capybara.app_host = ENV.fetch('BASE_URL', 'https://the-internet.herokuapp.com')

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--disable-gpu')
  options.add_argument('--window-size=1400,900')
  options.add_argument('--ignore-certificate-errors')
  options.add_argument('--allow-insecure-localhost')
  
  # Use system chromium in Docker
  if ENV['CHROME_BIN']
    options.binary = ENV['CHROME_BIN']
  end
  
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
