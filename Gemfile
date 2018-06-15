source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
# ruby '2.5.0'
gem 'rails', '~> 5.2.0'
gem "bootsnap", ">= 1.1.0", require: false
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'jquery-turbolinks'

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass'
gem 'devise'
gem 'high_voltage'

gem 'jquery-rails'
gem 'mysql2', '~> 0.5.0'
gem 'simple_form'
gem 'figaro'
gem 'cancan'
gem 'sidekiq'
gem 'sinatra', :require => nil
gem 'sidekiq-failures'
gem 'redis'
gem 'redis-rails'
gem 'redis-namespace'
gem 'ledermann-rails-settings', "~> 2.3.0"
gem 'administrate'
gem 'gmap_coordinates_picker'
gem "will_paginate" , "~> 3.1.1"

gem 'jwt'
gem 'active_model_serializers'
gem "paranoia"
gem "mini_magick"
gem "aws-sdk-s3", require: false
gem "omniauth-facebook", "~> 5.0.0"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"
gem "webpacker"
gem "react-rails"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end
group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "letter_opener"
end

group :development do
  gem 'better_errors'
  gem 'capistrano', '~> 3.0.1'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rails-console'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'hub', :require=>nil
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'spring-commands-rspec'
end
group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
end
group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem "capybara-screenshot"
  gem "chromedriver-helper"
  gem "cucumber-rails", require: false
  gem "selenium-webdriver"
  gem "shoulda"
  gem "site_prism", "~> 2.11"
  gem 'faker'
end
