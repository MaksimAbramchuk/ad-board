class AdvertsController < ApplicationController

  include ApplicationHelper

  skip_before_action :authenticate_user!, only:[:index, :filter]
  load_and_authorize_resource

  def index
    @adverts = @search.result.published.page params[:page]
    @search.build_condition if @search.conditions.empty?
  end

  def new
  end

  def create
    @advert.user = current_user
    if @advert.save
      flash[:notice] = t('flash.advert.create.success') 
      redirect_to users_adverts_path
    else
      flash.now[:alert] = list_saving_errors(@advert)
      render :new
    end
  end

  def edit
  end

  def update
    if @advert.update(advert_params)
      flash[:notice] = t('flash.advert.update.success')
      redirect_to root_path
    else
      flash.now[:alert] = list_saving_errors(@advert)
      render :edit
    end
  end

  def awaiting_publication
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
      flash[:notice] = t('flash.advert.change_state.success')
      redirect_to users_adverts_path
    else
      render :change
    end
  end

  def logs
    @operations = Operation.list_all(@advert)
  end
  
  def filter
    @search.build_condition if @search.conditions.empty?
    @adverts = Advert.category_filter(params[:query]).page params[:page]
    render :index
  end

  def destroy
    @advert.destroy
    unless @advert.persisted?
      flash[:notice] = t('flash.advert.delete.success')
    else
      flash.now[:alert] = t('flash.advert.delete.error')
    end
    redirect_to root_path
  end

  protected

  def advert_params
    params.require(:advert).permit(:name, :description, :price, :comment, :state, :category_id, :kind, images_attributes: [:id, :image, :_destroy])
  end

  def state_params
    params.require(:advert).permit(:state)
  end

end
