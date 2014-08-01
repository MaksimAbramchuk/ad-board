require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module AdvBoard
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('lib', '**')]

    config.generators do |g|
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
      g.test_framework :rspec
    end
  end
end
