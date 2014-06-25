class Ability

  include CanCan::Ability

  def initialize(user)
    alias_action :create, :update, :destroy, :to => :modify

    user ||= User.new
    if user.admin?
      can [:archive, :publish, :decline], Advert
      can :modify, Category 
    elsif user.common?
      can [:archive, :send_for_publication], Advert
    end
  end

end
