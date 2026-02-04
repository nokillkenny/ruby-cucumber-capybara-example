After do |scenario|
	if scenario.failed?
		attach(page.save_screenshot(nil), 'image/png')
	end
end