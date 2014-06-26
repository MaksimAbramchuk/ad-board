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

  protected
  
  def advert_params
    params.require(:advert).permit(:name, :description, :price)
  end

end
