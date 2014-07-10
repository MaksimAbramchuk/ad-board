Devise.setup do |config|
  AppConfig.setup!(yaml: "#{Rails.root}/config/appconfig.defaults.yml")
  config.omniauth :facebook, AppConfig.omniauth['facebook']['key'], AppConfig.omniauth['facebook']['secret'],strategy_class: OmniAuth::Strategies::Facebook
  config.omniauth :vkontakte, AppConfig.omniauth['vkontakte']['key'], AppConfig.omniauth['vkontakte']['secret']
  config.omniauth :twitter, AppConfig.omniauth['twitter']['key'], AppConfig.omniauth['twitter']['secret']
end
