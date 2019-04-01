class CartsController < ApplicationController
  include CartsHelper

  def show
    @cart = Cart.includes(line_items: [product_type: [product: :picture]]).find(session[:cart_id])
  end

  def add_product
    product = ProductType.find(params[:id])
    current_cart.add_product(product).try(:save)

    redirect_to current_cart
  end
end
