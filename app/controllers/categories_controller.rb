class CategoriesController < ApplicationController
  def show
    @category = Category.includes(products: %i[picture product_types]).find(params[:id])
  end
end
