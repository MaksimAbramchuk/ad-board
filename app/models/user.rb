class User < ActiveRecord::Base
  has_many :adverts
  has_one :avatar, class_name: :Image, as: :imageable

  validates :email, :name, presence: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :twitter]
  
  accepts_nested_attributes_for :avatar, reject_if: ->(t) { t['image'].nil? }, allow_destroy: true

  extend Enumerize
  enumerize :role, in: [:user, :admin], default: :user, predicates: true

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
  end
end
