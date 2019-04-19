class CartsController < ApplicationController
  include ProductsHelper

  def show
    @cart = Cart.includes(line_items: [product_type: [product: :picture]]).find(session[:cart_id])

    buy_together
  end

  def add_product
    product = ProductType.find(params[:id])
    current_cart.add_product(product).try(:save)

    respond_to do |format|
      format.js
    end
  end

  def buy_together
    ids = product_ids(current_cart).uniq

    product_ids = ProductSale.where('active_id IN (?) AND passive_id NOT IN (?)', ids, ids).order(sales_count: :desc)
                             .pluck(:passive_id).uniq.first(3)

    @products = Product.includes(:product_types, :picture).where(id: product_ids)
  end
end
