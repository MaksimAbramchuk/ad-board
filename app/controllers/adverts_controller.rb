class AdvertsController < ApplicationController

  def index
    @adverts = Advert.where(state: "published")
  end

  def new
    @advert = Advert.new
    @categories = Category.all
  end

  def create
    @advert = Advert.create(advert_params)
    @advert.user = current_user
    @advert.save
    render text: "Advert has been succesfully added"
  end

  def awaiting_publication
    unless current_user.send(:admin?)
      redirect_to root_path
    end
    @adverts = Advert.where(state: "awaiting_publication")
  end

  def change
    @advert = Advert.find(params[:advert_id])  
  end

  def change_state
    @advert = Advert.find(params[:advert_id])
    @advert.send(state_params[:state])
    if @advert.save
      redirect_to account_adverts_path
    else
      render "change"
    end
  end

  protected
  
  def advert_params
    params.require(:advert).permit(:name, :description, :price)
  end

  def state_params
    params.require(:advert).permit(:state)
  end

end
