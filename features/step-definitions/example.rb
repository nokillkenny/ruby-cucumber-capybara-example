main_page = MainPage.new
listings_page = ListingsPage.new


Given(/^I visit redfin$/) do
  visit 'http://www.redfin.com'
end

When(/^I log in with my credentials$/) do
  main_page.wait_for_main_to_load
  main_page.click_login
  main_page.login_to_email
  main_page.validate_logged_in
end

When(/I search for the "(.*)" in the address listing/) do |name|
  # search city
  main_page.search_for_city(name)
  main_page.click_listed_city
end

Then(/I see "(.*)" in the page header$/) do |header_title|
  listings_page.check_title(header_title)
end

When(/I apply filter details$/) do
  listings_page.wait_for_listings_to_load

  listings_page.set_min_house_price_to('$1M')
  listings_page.set_max_house_price_to('$2M')
  listings_page.click_filter_details
  listings_page.set_min_bed_to(4)
  listings_page.set_max_bed_to(4)
  listings_page.set_property('House')
  listings_page.toggle_sold_houses
  listings_page.toggle_houses_for_sale

  listings_page.apply_filters

end

When(/I scroll down to load the filtered houses/) do
  listings_page.load_all_listings
end

Then(/I expect all houses listed to be sold$/) do
  listings_page.validate_listed_pages_are_sold
end

Then(/I expect the price range to be between (\d+) and (\d+)$/) do |min_price, max_price|
  listings_page.validate_accurate_price_ranges(min_price, max_price)
end

# This step might fail because redfin sometimes return houses with 3 bedrooms
Then(/I expect all listed homes to have 4 bedrooms$/) do
  listings_page.validate_bedrooms_in_listing
end