# frozen_string_literal: true

require "cucumber/rails"

# Sometimes we want to override this default behaviour and allow Rails to rescue
# exceptions and display an error page.
# (just like when the app is running in production)
# to do so Tag your scenario (or feature) with @allow-rescue
ActionController::Base.allow_rescue = false

#begin
  DatabaseCleaner.strategy                  = :transaction
# rescue NameError
#   raise "You need to add database_cleaner to your Gemfile"\
#         " (in the :test group) if you wish to use it."
# end

if chrome_bin = ENV.fetch("GOOGLE_CHROME_SHIM", nil)
  chrome_opts = { "chromeOptions" => { "binary" => chrome_bin } }

  Capybara.register_driver :chrome do |app|
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(chrome_opts)
    Capybara::Selenium::Driver.new(
        app,
        browser:              :chrome,
        desired_capabilities: capabilities
    )
  end
  Capybara.javascript_driver = :chrome
else
  Capybara.javascript_driver = :selenium_chrome_headless
end

Cucumber::Rails::Database.javascript_strategy = :truncation

Before "@javascript" do
  Capybara.current_session.current_window.resize_to(1260, 700)
end
