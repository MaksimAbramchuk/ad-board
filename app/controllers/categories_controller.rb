class CategoriesController < ApplicationController

  before_action :redirect_if_not_admin
  load_and_authorize_resource

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      redirect_to new_category_path
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      redirect_to :back
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  protected

  def category_params
    params.require(:category).permit(:name)
  end

  def redirect_if_not_admin
    unless can? :manage, Category
      redirect_to root_path
    end
  end

end
