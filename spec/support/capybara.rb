RSpec.configure do |config|
  config.when_first_matching_example_defined(type: :system) do
    require "capybara/rspec"
    Capybara.server_host = "0.0.0.0"
    Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}"
  end

  config.before(:context, type: :system) do
    driven_by(:rack_test)
  end

  config.before(:context, :js, type: :system) do
    options = {browser: :remote, url: ENV["SELENIUM_REMOTE_URL"]}
    driven_by(:selenium, using: :firefox, options:)
  end
end
