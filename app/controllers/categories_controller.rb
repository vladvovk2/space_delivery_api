class CategoriesController < ApplicationController
  before_action :set_category, only: :show

  def index
    @categories = Category.all
  end

  def show; end

  private

  def set_category
    @category = Category.includes(products: :picture).find(params[:id])
  end
end
