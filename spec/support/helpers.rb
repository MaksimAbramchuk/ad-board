Dir[Rails.root.join("spec/support/{controllers,features}/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.extend Controllers::RolesAccessHelper, type: :controller
end