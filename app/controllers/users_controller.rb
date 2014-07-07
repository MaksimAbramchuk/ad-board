class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    if current_user.role.admin?
      @user = User.includes(:adverts).find(params[:id])
      @awaiting = @user.adverts.awaiting_publication
      @declined = @user.adverts.declined
      @published = @user.adverts.published
    else
      @user = User.find(params[:id])
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.build_avatar unless @user.avatar
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :email, :role, avatar_attributes: [:id, :image, :_destroy])
  end

end
