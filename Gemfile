source 'https://rubygems.org'
ruby "2.4.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'bootstrap', '~> 4.1.2'
gem 'jquery-rails'
gem 'pg'
gem 'faraday'
gem 'figaro'
gem 'bcrypt'
gem 'friendly_id', '~> 5.1.0'
gem 'octicons_helper'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'letter_opener'
gem 'sprockets', '~> 3.7.2'
gem 'rubyzip', '~> 1.2.2'
gem 'ffi', '~> 1.9.24'
gem 'loofah', '~> 2.2.3'

group :development, :test do
  gem "pry"
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.7'
  gem 'selenium-webdriver'
  gem 'fabrication'
  gem 'faker'
  gem 'rails-controller-testing'
end
