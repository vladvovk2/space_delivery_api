class CartsController < ApplicationController
  include ProductsHelper

  before_action :give_away, only: :show

  def show
    @cart = Cart.includes(line_items: [product_type: [product: :picture]])
                .find(session[:cart_id])

    buy_together
  end

  def add_product
    @product_type = ProductType.find(params[:id])

    AddProduct.call(@product_type, current_cart, current_user) { on(:ok) { |message| send_notification(message) } }

    respond_to { |format| format.js }
  end

  def buy_together
    product_ids = ProductSale
                  .where('active_id IN (:ids) AND passive_id NOT IN (:ids)', ids: product_ids(current_cart).uniq)
                  .order(sales_count: :desc)
                  .pluck(:passive_id).uniq

    @products = Product
                .includes(:product_types, :picture)
                .where('id IN (?) AND published IS ?', product_ids, true)
                .limit(3)
  end

  private

  def give_away
    GiveAwayJob.perform_later(current_cart.id)
  end
end
