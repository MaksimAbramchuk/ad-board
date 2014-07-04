class Ability

  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.role == 'admin'
      can [:edit, :see_logs, :publish, :decline, :change_state], Advert
      can :modify, Category
    elsif user.role == 'user'
      can [:archive, :send_for_publication], Advert
    end
  end

end
