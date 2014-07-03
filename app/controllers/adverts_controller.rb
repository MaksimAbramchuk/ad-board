class AdvertsController < ApplicationController

  skip_before_action :authenticate_user!, only: :index

  def index
    @search = Advert.search(params[:q])
    @adverts = @search.result.where(state: :published).page params[:page]
  end

  def new
    @advert = Advert.new
  end

  def create
    @advert = Advert.create(advert_params)
    @advert.user = current_user
    if @advert.save
      redirect_to account_adverts_path
    else
      redirect_to new_advert_path
    end
  end

  def edit
    @advert = Advert.find(params[:id])    
    redirect_to root_path if (@advert.user != current_user)||(current_user.send(:admin?))
  end

  def update
    @advert = Advert.find(params[:id])
    if @advert.update(advert_params)
      redirect_to root_path
    else
      redirect_to edit_advert_path(advert)
    end
  end

  def awaiting_publication
    unless current_user.send(:admin?)
      redirect_to root_path
    end
    @adverts = Advert.where(state: "awaiting_publication").order(updated_at: :desc)
  end

  def change
    @advert = Advert.find(params[:advert_id]) 
    @comment = Comment.new 
  end

  def change_state
    @advert = Advert.find(params[:advert_id])
    @advert.send(state_params[:state])
    if @advert.declined?
      @operation = Operation.where(advert_id: @advert.id).where(user_id: current_user.id).where(to: "declined").last
      @comment = Comment.create(advert: @advert, comment: advert_params[:comment], operation: @operation)
    end
    if @advert.save
      redirect_to account_adverts_path
    else
      redirect_to advert_change_path(@advert)
    end
  end

  def logs
    @advert = Advert.find(params[:id])
    @operations = Operation.where(advert_id: @advert.id)
  end

  protected
  
  def advert_params
    params.require(:advert).permit(:name, :description, :price, :comment, :state, :category_id, :kind, images_attributes: [:id,:image,:_destroy])
  end

  def state_params
    params.require(:advert).permit(:state)
  end

end
