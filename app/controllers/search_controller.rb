class SearchController < ApplicationController

  def result
    @search = Advert.search(params[:q])
    @adverts = @search.result
  end

  protected

  def query_params
    params.require(:query).permit(:description)
  end

end
