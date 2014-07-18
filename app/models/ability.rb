class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.admin?
      can :manage, Advert
      can :manage, Category
      can [:manage, :change, :see_publications, :change_role], User
    elsif user.user?
      can [:index, :new, :create, :filter], Advert
      can [:edit, :change_state, :logs, :change], Advert, user_id: user.id
      can [:show, :account, :adverts, :new, :create], User
      can [:change, :edit, :update], User, id: user.id
    end
  end

end
