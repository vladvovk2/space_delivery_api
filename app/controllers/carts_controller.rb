class CartsController < ApplicationController
  include CartsHelper

  def add_product
    product = ProductType.find(params[:id])
    current_cart.add_product(product).try(:save)

    redirect_to current_cart
  end
end
