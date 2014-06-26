class User < ActiveRecord::Base

  has_many :adverts
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  ROLES = %w{admin user guest}

  class << self

    def current_user
      Thread.current[:user]
    end
    
    def current_user=(user)
      Thread.current[:user] = user
    end
  
  end
  
  protected 
  
  def admin?
    User.current_user.role == "admin"  
  end
end
