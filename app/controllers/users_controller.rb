class UsersController < ApplicationController
  
  def all
    @users = User.all  
  end

  def show
    if current_user.send(:admin?)
      @user = User.includes(:adverts).find(params[:id])
      @awaiting = @user.adverts.where(state: "awaiting_publication")
      @declined = @user.adverts.where(state: "declined")
      @published = @user.adverts.where(state: "published")
    else
      @user = User.find(params[:id])
    end
  end

end
