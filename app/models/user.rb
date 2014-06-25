class User < ActiveRecord::Base
  has_many :adverts
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
end
