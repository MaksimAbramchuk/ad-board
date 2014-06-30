class SearchController < ApplicationController
  
  def result
    regexp = Regexp.new(query_params[:description])
    @adverts = Advert.all.select {|a| regexp.match(a.description) }
  end

  protected
  
  def query_params
    params.require(:query).permit(:description)
  end

end
