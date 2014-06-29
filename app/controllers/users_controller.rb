class UsersController < ApplicationController
  
  def all
    @users = User.all  
  end

  def show
    if current_user.send(:admin?)
      @user = User.includes(:adverts).find(params[:id])
      @awaiting = @user.adverts.where(state: "awaiting_publication").order(updated_at: :desc)
      @declined = @user.adverts.where(state: "declined").order(updated_at: :desc)
      @published = @user.adverts.where(state: "published").order(updated_at: :desc)
    else
      @user = User.find(params[:id])
    end
  end

end
