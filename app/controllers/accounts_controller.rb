class AccountsController < ApplicationController
  
  def role
    @role = current_user.role
  end
  
  def change_role
    current_user.update(role_params)
    current_user.save
    redirect_to :back
  end

  def index
    if current_user.send(:admin?)
      render 'admin_account'
    else
      render 'user_account'
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
