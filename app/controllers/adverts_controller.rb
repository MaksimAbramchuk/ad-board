class AdvertsController < ApplicationController

  def index
    @adverts = Advert.where(state: "published")
  end

  def new
    @advert = Advert.new
  end

  def create
    @advert = Advert.create(advert_params)
    @category = Category.find_by(name: advert_category[:category])
    @advert.category = @category
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

  def advert_category
    params.require(:advert).permit(:category)
  end
end
