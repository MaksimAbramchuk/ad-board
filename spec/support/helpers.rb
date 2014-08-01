Dir[Rails.root.join('spec/support/{controllers,features}/**/*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.extend Controllers::RolesAccessHelper, type: :controller
end
