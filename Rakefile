#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Privly::Application.load_tasks

desc 'Run Jasmine tests with Webdriver'
task :webdriver do
	
	# Detect which browser we want to run
	case ENV['browser']
	when 'chromium'
		#TODO: detect chromium path? I use Linux, this is the path on my machine
		Selenium::WebDriver::Chrome.path = '/usr/lib/chromium-browser/chromium-browser'
		driver = Selenium::WebDriver.for :chrome
	when 'firefox'
		driver = Selenium::WebDriver.for :firefox
	else
		raise ArgumentError, 'Unknown browser requested'
	end
	
	test_pages = ["http://localhost:3000/apps/Help/new.html",
	"http://localhost:3000/apps/Login/new.html",
	"http://localhost:3000/apps/Index/new.html",
	"http://localhost:3000/apps/PlainPost/new.html",
#	"http://localhost:3000/apps/PlainPost/show.html",
	"http://localhost:3000/apps/ZeroBin/new.html",
#	"http://localhost:3000/apps/ZeroBin/show.html"
	]

	# Finally, we load the HTML pages with Webdriver
	test_pages.each do |x|
	  driver.navigate.to x
	  # Allow it to load
	  sleep 3
	  status = driver.execute_script('return consoleReporter.status;')
	  output = driver.execute_script('return consoleReporter.getLogsAsString();')
	  print output
	  # Make sure to exit with code > 0 if there is a test failure
	  #raise RuntimeError, 'Failure' unless status === 'success'
	end
	driver.quit
end
