class UsersController < Devise::RegistrationsController

  before_filter :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    authorize! :index, User
  end

  def show
    authorize! :show, @user
    @awaiting = @user.adverts.awaiting_publication
    @declined = @user.adverts.declined
    @published = @user.adverts.published
  end

  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def adverts
    @adverts = current_user.adverts.including_all.order(updated_at: :desc).page params[:page]
  end

  def account
    if current_user.admin?
      render :admin_account
    else
      render :user_account
    end
  end

  protected

  def user_params
    if current_user.admin?
      params.require(:user).permit(:name, :email, :role, avatar_attributes: [:id, :image, :_destroy])
    elsif current_user.user?
      params.require(:user).permit(:name, :email, avatar_attributes: [:id, :image, :_destroy])
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
