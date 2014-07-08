class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    alias_action :create, :update, :destroy, to: :modify
    if user.role.admin?
      can [:edit, :change_state, :update, :change, :logs], Advert
      can :modify, Category
      can [:change, :see_publications, :show, :edit, :update, :change_role], User
    elsif user.role.user?
      can [:edit, :change_state, :logs], Advert, user_id: user.id
      can :show, User
      can [:change, :edit, :update], User, id: user.id
    end
  end

end
