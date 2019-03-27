class CategoriesController < ActionController::Base
  before_action :set_category, only: :show

  def index
    @categories = Category.all
  end

  def show; end

  private

  def set_category
    @category = Category.includes(products: %i[product_types picture]).find(params[:id])
  end
end
