class AccountsController < ApplicationController

  def index
    if current_user.role.admin?
      render :admin_account
    else
      render :user_account
    end
  end

  def adverts
    @adverts = current_user.adverts.order(updated_at: :desc).page params[:page]
  end

  protected

  def role_params
    params.require(:user).permit(:role)
  end

end
