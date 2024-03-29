require 'capybara/cucumber'
require 'selenium-webdriver'
require 'capybara/session'
require 'capybara/dsl'
require 'capybara/rspec'

require_relative '../step-definitions/pages/main.rb'
require_relative '../step-definitions/pages/listings.rb'

Capybara.default_driver = :selenium

Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.javascript_driver = :firefox
