RSpec.configure do |config|
  config.include Features::SessionHelper, type: :feature
  config.include Features::AdvertsHelper, type: :feature
end