class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    alias_action :create, :update, :destroy, to: :modify
    if user.role == 'admin'
      can [:edit, :see_logs, :change_state], Advert
      can :modify, Category
    elsif user.role == 'user'
      can [:edit, :see_logs, :change_state], Advert, user_id: user.id
    end
  end

end
