class AdvertsController < ApplicationController

  def index
    @search = Advert.search(params[:q])
    @adverts = @search.result.where(state: :published)
  end

  def new
    @advert = Advert.new
    @categories = Category.all
  end

  def create
    @advert = Advert.create(advert_params)
    @advert.user = current_user
    @advert.save
    redirect_to account_adverts_path
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
      render "change"
    end
  end

  def logs
    @advert = Advert.find(params[:id])
    @operations = Operation.where(advert_id: @advert.id)
  end

  protected
  
  def advert_params
    params.require(:advert).permit(:name, :description, :price, :comment, :category_id, :kind, images_attributes: [:id,:image,:_destroy])
  end

  def state_params
    params.require(:advert).permit(:state)
  end

end
