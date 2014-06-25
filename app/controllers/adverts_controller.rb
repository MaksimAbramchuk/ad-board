class AdvertsController < ApplicationController

  def index
    @adverts = Advert.where(state: "published")  
    binding.pry
  end

end
