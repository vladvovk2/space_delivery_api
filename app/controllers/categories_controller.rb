class CategoriesController < ApplicationController
  before_action :set_categories

  def show
    @category = Category.includes(products: %i[picture product_types]).find(params[:id])
  end

  private

  def set_categories
    @categories = Category.all
  end
end
