Given(/^I visit redfin$/) do
  visit 'http://www.redfin.com'
end

When(/^I log in with my credentials$/) do
  #wait for page to fully load
  has_no_css?('.searchInputNode #search-box-input[disabled=""]')
  # click login
  find_button('Log In').click
  # click email
  find('.emailSignInButton').click
  find('.submitButton').click
  #fill in email and pw
  fill_in('Email', with: 'klin@mailinator.com')
  fill_in('Password', with: 'Tester123')
  #submit email
  find('.submitButton').click
  #validate login
  expect(page).to have_css('.header-right', text: 'Tester')
end

When(/I search for the "(.*)" in the address listing/) do |city|
  # search city
  find('.searchInputNode #search-box-input').set('')
  find('.searchInputNode #search-box-input').send_keys(city)

  # wait for listing and click
  find('.expanded-row-content', text: 'PLACES')
  find('.item-row.clickable', text: 'Newport Beach', match: :first).click

end

Then(/I see "(.*)" in the page header$/) do |header_title|
  expect(page).to have_css('.sidepaneHeader', text: header_title)
end

When(/I apply filter details$/) do
  #wait for assets to load
  find('[data-rf-test-name="SellMenu"]').hover
  expect(page).to have_css('.flyout', wait: 10)


  # set min price to number
  find('.quickMinPrice').click
  find('.option', text: '$1M').click

  # set max price to number
  find('.quickMaxPrice').click
  find('.option', text: '$2M').click


  #click filter details
  find('.wideSidepaneFilterButton').click
  find('#filterContent')

  #set min bed options to number
  find('.minBeds').click
  find('.option', text: 4).click

  #set max bed options to number
  find('.maxBeds').click
  find('.option', text: 4).click

  #search houses only
  find('.propertyTypeRow span', text: 'House').click

  # Toggle sold houses only
  find('[data-rf-test-id="soldsToggleRow"] .input .decoration').click
  find('[data-rf-test-id="forSaleToggleRow"] .input').click

  #apply filters
  find('.applyButton').click
end

When(/I scroll down to load the filtered houses/) do
  page.execute_script 'window.scrollBy(0,750)'
  sleep(0.5)
  page.execute_script 'window.scrollBy(0,750)'
  sleep(0.5)
  page.execute_script 'window.scrollBy(0,750)'
  sleep(0.5)
end

Then(/I expect all houses listed to be sold$/) do
  houses_sold = all('.sold').count
  houses_listed= all('.homecard').count

  expect(houses_sold).to match(houses_listed)
end

Then(/I expect the price range to be between (\d+) and (\d+)$/) do |min_price, max_price|
  listed_home_details = all('.homecardPrice').map{|a| a.text.gsub('$',"").gsub(',',"").to_i}
  houses_out_of_range= listed_home_details.select{|price| (min_price > price || price > max_price)}
  expected_number= houses_out_of_range.count
  expect(expected_number).to match(0), "There were houses outside price range: #{houses_out_of_range}"
end

Then(/I expect all listed homes to have 4 bedrooms$/) do
  listed_home_details = all('.homecard').map{|a| a.text}
  houses_not_sold= listed_home_details.reject{|beds| beds.include?"4\nBeds"}
  expect(houses_not_sold).to be_empty, "Expected 4 bedrooms for all results: #{houses_not_sold}"
  # This test might fail because redfin sometimes return houses with 3 bedrooms
end