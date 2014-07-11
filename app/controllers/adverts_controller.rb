class AdvertsController < ApplicationController

  skip_before_action :authenticate_user!, only: :index
  load_and_authorize_resource

  def index
    @search = Advert.search(params[:q])
    @adverts = @search.result.published.page params[:page]
    @search.build_condition if @search.conditions.empty?
  end

  def new
    @advert = Advert.new
  end

  def create
    @advert = Advert.create(advert_params)
    @advert.user = current_user
    if @advert.save
      redirect_to users_adverts_path
    else
      redirect_to new_advert_path
    end
  end

  def edit
    redirect_to root_path if (@advert.user != current_user) && !current_user.role.admin?
  end

  def update
    if @advert.update(advert_params)
      redirect_to root_path
    else
      redirect_to edit_advert_path(advert)
    end
  end

  def awaiting_publication
    unless current_user.role.admin?
      redirect_to root_path
    end
    @adverts = Advert.awaiting_publication
  end

  def change
    @comment = Comment.new
  end

  def change_state
    status_service = AdvertStatusService.new(@advert, current_user)
    status_service.send(state_params[:state])
    if @advert.declined?
      @operation = Operation.find_according(@advert, current_user)
      @comment = Comment.create(advert: @advert, comment: advert_params[:comment], operation: @operation)
    end
    if @advert.save
      redirect_to users_adverts_path
    else
      redirect_to advert_change_path(@advert)
    end
  end

  def logs
    @operations = Operation.list_all(@advert)
  end

  protected

  def advert_params
    params.require(:advert).permit(:name, :description, :price, :comment, :state, :category_id, :kind, images_attributes: [:id, :image, :_destroy])
  end

  def state_params
    params.require(:advert).permit(:state)
  end

end
