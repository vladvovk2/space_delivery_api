class ApplicationController < ActionController::Base
  before_action :set_category
  before_action :set_categories
  before_action :load_cart

  private

  def set_category
    @cate = Category.first
  end

  def set_categories
    @categories = Category.all
  end

  def load_cart
    @cart = Cart.find(session[:cart_id]) if session[:cart_id].present?
  end
end
