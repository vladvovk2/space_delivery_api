class CartsController < ApplicationController
  include ProductsHelper

  def show
    @cart = Cart.includes(line_items: [product_type: [product: :picture]]).find(session[:cart_id])

    buy_together
  end

  def add_product
    product = ProductType.find(params[:id])
    current_cart.add_product(product).try(:save)
    ActionCable.server.broadcast :notifiations, message: "#{product.product.title} added to cart."

    respond_to do |format|
      format.js
    end
  end

  def buy_together
    ids = product_ids(current_cart).uniq

    product_ids = ProductSale.where('active_id IN (?) AND passive_id NOT IN (?)', ids, ids).order(sales_count: :desc)
                             .pluck(:passive_id).uniq

    @products = Product.includes(:product_types, :picture)
                       .where('id IN (?) AND published IS ?', product_ids, true).limit(3)
  end
end
