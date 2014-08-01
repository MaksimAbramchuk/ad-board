ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'spec_helper'
require 'rspec/rails'
require 'capybara/rspec'
require 'shoulda-matchers'

Dir[Rails.root.join("spec/{support,fabricators}/**/*.rb")].each { |file| require file }

RSpec.configure do |config|
  Capybara.javascript_driver = :webkit
  config.include Formulaic::Dsl, type: :feature
  config.include Devise::TestHelpers, type: :controller

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    if example.metadata[:js]
      DatabaseCleaner.strategy = :truncation
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
