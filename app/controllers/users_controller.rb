class UsersController < Devise::RegistrationsController
  include ApplicationHelper

  before_filter :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
    authorize! :index, User
  end

  def show
    authorize! :show, @user
    [:awaiting_publication, :declined, :published].each do |state|
      instance_variable_set("@#{state}", @user.adverts.send(state))
    end
  end

  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      flash[:notice] = t('flash.user.update.success')
      redirect_to user_path(@user)
    else
      flash.now[:alert] = list_saving_errors(@user)
      render :edit
    end
  end

  def adverts
    @adverts = current_user.adverts.including_all.order(updated_at: :desc).page params[:page]
  end

  def account
    if current_user.admin?
      render :admin_account
    elsif current_user.user?
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
