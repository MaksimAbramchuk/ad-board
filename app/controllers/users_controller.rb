class UsersController < Devise::RegistrationsController

  load_and_authorize_resource

  def index
  end

  def show
    @awaiting = @user.adverts.awaiting_publication
    @declined = @user.adverts.declined
    @published = @user.adverts.published
  end

  def edit
    @user.build_avatar unless @user.avatar
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  def adverts
    @adverts = current_user.adverts.including_all.order(updated_at: :desc).page params[:page]
  end

  def account
    if current_user.role.admin?
      render :admin_account
    else
      render :user_account
    end
  end

  protected

  def user_params
    if current_user.role.admin?
      params.require(:user).permit(:name, :email, :role, avatar_attributes: [:id, :image, :_destroy])
    elsif current_user.role.user?
      params.require(:user).permit(:name, :email, avatar_attributes: [:id, :image, :_destroy])
    end
  end

end
