class User < ActiveRecord::Base

  has_many :adverts

  validates :email, :name, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :twitter]

  ROLES = %w(admin user)

  class << self

    def find_for_social_oauth(auth)
      User.find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = "#{auth.uid}@#{auth.provider}.com"
        user.password = Devise.friendly_token[0, 20]
        user.name = auth.info.name
      end
    end

    def current_user
      Thread.current[:user]
    end
    
    def current_user=(user)
      Thread.current[:user] = user
    end
  
  end
  
  protected
  
  def admin?
    User.current_user.role == 'admin'
  end
end
