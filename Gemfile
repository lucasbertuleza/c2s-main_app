source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.6"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.0"
# Use mysql as the database for Active Record
gem "mysql2"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# gem "stimulus-rails"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  # https://github.com/thoughtbot/factory_bot_rails
  gem "factory_bot_rails"
  # https://github.com/pry/pry-rails
  gem "pry-rails"
  # https://github.com/rspec/rspec-rails
  gem "rspec-rails"
  # https://rubocop.org/
  gem "rubocop", require: false
  # https://github.com/rubocop/rubocop-capybara
  gem "rubocop-capybara", require: false
  # https://github.com/rubocop/rubocop-factory_bot
  gem "rubocop-factory_bot", require: false
  # https://github.com/rubocop/rubocop-performance/
  gem "rubocop-performance", require: false
  # https://docs.rubocop.org/rubocop-rails/
  gem "rubocop-rails", "~> 2.23.1", require: false
  # https://github.com/rubocop/rubocop-rspec
  gem "rubocop-rspec", require: false
  # https://github.com/rubocop/rubocop-rspec_rails
  gem "rubocop-rspec_rails", require: false
  # https://github.com/standardrb/standard
  gem "standard", require: false
  # https://github.com/standardrb/standard-rails
  gem "standard-rails", require: false
end

group :development do
  # https://github.com/flyerhzm/bullet
  gem "bullet"
  # https://github.com/puma/puma#self-signed-ssl-certificates-via-the-localhost-gem-for-development-use
  gem "localhost"
  # https://github.com/castwide/solargraph
  gem "solargraph", require: false
  # https://github.com/iftheshoefritz/solargraph-rails/
  gem "solargraph-rails", require: false
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # https://github.com/presidentbeef/brakeman
  gem "brakeman", require: false
  # https://github.com/DatabaseCleaner/database_cleaner
  gem "database_cleaner-active_record"
  # https://github.com/Shopify/erb-lint
  gem "erb_lint", require: false
  # https://github.com/flyerhzm/rails_best_practices
  gem "rails_best_practices", require: false
  # https://github.com/troessner/reek
  gem "reek", require: false
  # https://matchers.shoulda.io/docs
  gem "shoulda-matchers"
  # https://github.com/simplecov-ruby/simplecov
  gem "simplecov", require: false

  # System Testing

  # https://rubygems.org/gems/capybara
  gem "capybara"
  # https://rubygems.org/gems/selenium-webdriver
  gem "selenium-webdriver"
end

# https://github.com/zdennis/activerecord-import
gem "activerecord-import"
# https://github.com/Shopify/better-html
gem "better_html"
# https://github.com/drapergem/draper
gem "draper"
# Enable support for the faster hiredis connection library.
# Redis cache store will automatically require and use hiredis if available.
gem "hiredis"
# https://github.com/redis/redis-rb
gem "redis"
# https://sidekiq.org/
gem "sidekiq"
# https://viewcomponent.org/
gem "view_component"
# https://vite-ruby.netlify.app/
gem "vite_rails"
gem "hutch"