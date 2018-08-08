class ListingsPage
  include Capybara::DSL
  include RSpec::Matchers

  PAGE_HEADER ||= '.sidepaneHeader'
  SELL_MENU ||= '[data-rf-test-name="SellMenu"]'
  FLYOUT_POPUP ||= '.flyout'
  MAX_PRICE_DROPDOWN ||= '.quickMaxPrice'
  MIN_PRICE_DROPDOWN ||= '.quickMinPrice'
  DROPDOWN_OPTIONS ||= '.option'
  LISTED_HOUSES ||= '.homecard'
  LISTED_HOUSE_PRICES ||= '.homecardPrice'
  HOUSES_LISTED_AS_SOLD ||= '.sold'
  MORE_FILTER_OPTIONS_LINK ||= '.wideSidepaneFilterButton'
  FILTER_CONTENT ||= '#filterContent'
  MIN_BED_DROPDOWN ||= '.minBeds'
  MAX_BED_DROPDOWN ||= '.maxBeds'
  SOLD_TOGGLE ||= '[data-rf-test-id="soldsToggleRow"] .input .decoration'
  APPLY_BUTTON ||= '.applyButton'
  FOR_SALE_TOGGLE ||= '[data-rf-test-id="forSaleToggleRow"] .input'
  PROPERTY_TYPE_BUTTON ||= '.propertyTypeRow span'

  def check_title(header_title)
    expect(page).to have_css(PAGE_HEADER, text: header_title)
  end

  def wait_for_listings_to_load
    find(SELL_MENU).hover
    expect(page).to have_css(FLYOUT_POPUP, wait: 10)
  end

  def set_max_house_price_to(amount)
    find(MAX_PRICE_DROPDOWN).click
    find(DROPDOWN_OPTIONS, text: amount).click
  end

  def set_min_house_price_to(amount)
    find(MIN_PRICE_DROPDOWN).click
    find(DROPDOWN_OPTIONS, text: amount).click
  end

  def click_filter_details
    find(MORE_FILTER_OPTIONS_LINK).click
    find(FILTER_CONTENT)  #will wait if not loaded
  end

  def set_min_bed_to(amount)
    find(MIN_BED_DROPDOWN).click
    find(DROPDOWN_OPTIONS, text: amount).click
  end

  def set_max_bed_to(amount)
    find(MAX_BED_DROPDOWN).click
    find(DROPDOWN_OPTIONS, text: amount).click
  end

  def set_property(type)
    find(PROPERTY_TYPE_BUTTON, text: type).click
  end

  def toggle_sold_houses
    find(SOLD_TOGGLE).click
  end

  def toggle_houses_for_sale
    find(FOR_SALE_TOGGLE).click
  end

  def apply_filters
    find(APPLY_BUTTON).click
  end

  #this is needed when assets are lazy loaded only on browser focus
  def load_all_listings
    page.execute_script 'window.scrollBy(0,750)'
    wait_to_render
    page.execute_script 'window.scrollBy(0,750)'
    wait_to_render
    page.execute_script 'window.scrollBy(0,750)'
    wait_to_render
  end

  def validate_listed_pages_are_sold
    houses_sold = all(HOUSES_LISTED_AS_SOLD).count
    houses_listed = all(LISTED_HOUSES).count

    expect(houses_sold).to match(houses_listed)
  end

  def validate_accurate_price_ranges(min_price, max_price)
    listed_home_details = all(LISTED_HOUSE_PRICES).map {|a| a.text.gsub('$', "").gsub(',', "").to_i}
    houses_out_of_range = listed_home_details.select {|price| (min_price > price || price > max_price)}
    expected_number = houses_out_of_range.count
    expect(expected_number).to match(0), "There were houses outside price range: #{houses_out_of_range}"
  end

  def validate_bedrooms_in_listing
    listed_home_details = all(LISTED_HOUSES).map {|a| a.text}
    houses_not_sold = listed_home_details.reject {|beds| beds.include? "4\nBeds"}
    expect(houses_not_sold).to be_empty, "Expected 4 bedrooms for all results: #{houses_not_sold}"
  end

  private
  def wait_to_render
    sleep(0.3)
  end

end