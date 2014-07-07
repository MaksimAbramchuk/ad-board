class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    if current_user.send(:admin?)
      @user = User.includes(:adverts).find(params[:id])
      @awaiting = @user.adverts.awaiting_publication
      @declined = @user.adverts.declined
      @published = @user.adverts.published
    else
      @user = User.find(params[:id])
    end
  end

end
