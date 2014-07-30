class CategoriesController < ApplicationController
  include ApplicationHelper

  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @category.save
      flash[:notice] = t('flash.category.create.success')
      redirect_to categories_path
    else
      flash.now[:alert] = list_saving_errors(@category)
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = t('flash.category.update.success')
      redirect_to categories_path
    else
      flash.now[:alert] = list_saving_errors(@category)
      render :edit
    end
  end

  def destroy
    @category.destroy
    unless @category.persisted?
      flash[:notice] = t('flash.category.delete.success')
    else
      flash.now[:alert] = t('flash.category.delete.error')
    end
    redirect_to categories_path
  end

  protected

  def category_params
    params.require(:category).permit(:name)
  end

end
