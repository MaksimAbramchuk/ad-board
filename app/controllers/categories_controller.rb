class CategoriesController < ApplicationController
  
  before_action :redirect_if_not_admin

  def index
    @categories = Category.all
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
    else
      redirect_to :back
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end

  protected

  def category_params
    params.require(:category).permit(:name)
  end

  def redirect_if_not_admin
    unless current_user.send(:admin?)
      redirect_to root_path
    end
  end

end
