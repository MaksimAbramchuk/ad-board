class CategoriesController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
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

end
