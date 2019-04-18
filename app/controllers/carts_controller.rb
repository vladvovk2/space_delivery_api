class CartsController < ApplicationController
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
    ids = []

    current_cart.line_items.map do |ln|
      ids << ln.product_type.product.id
    end

    product_ids = ProductSale.where(active_id: ids.uniq).order(sales_count: :desc).limit(3).pluck(:passive_id)
    @products = Product.find(product_ids)
  end
end
