class CartsController < ApplicationController
  include ProductsHelper

  before_action :set_line_items, only: %i[add_product show buy_per_bonuses]

  def show
    @cart = Cart.includes(line_items: [product_type: [product: :picture]])
                .find(session[:cart_id])

    give_away
    buy_together
  end

  def add_product
    @product_type = ProductType.find(params[:id])
    item = @line_items.find_by(product_type: @product_type)

    if item
      item.update(quantity: item.quantity + 1)
      send_notification "#{@product_type.product.title} quantity increase to: #{item.quantity}."
    else
      @line_items.create(product_type: @product_type)
      send_notification "#{@product_type.product.title} added to cart."
    end

    respond_to { |format| format.js }
  end

  def buy_per_bonuses
    @product_type = ProductType.find(params[:id])

    if @product_type.product.per_bonuses
      if current_user.user_balance.balance >= @product_type.price
        item = @line_items.find_by(product_type: @product_type, per_bonuses: true)

        if item
          item.update(quantity: item.quantity + 1) if current_user.user_balance.update(balance: current_user.user_balance.balance - @product_type.price)
          send_notification "#{@product_type.product.title} quantity increase to: #{item.quantity}."
        else
          @line_items.create(product_type: @product_type, per_bonuses: true) if current_user.user_balance.update(balance: current_user.user_balance.balance - @product_type.price)
          send_notification "#{@product_type.product.title} added to cart."
        end
      end
    end

    respond_to { |format| format.js }
  end

  def buy_together
    ids = product_ids(current_cart).uniq

    product_ids = ProductSale.where('active_id IN (?) AND passive_id NOT IN (?)', ids, ids)
                             .order(sales_count: :desc)
                             .pluck(:passive_id).uniq

    @products = Product.includes(:product_types, :picture)
                       .where('id IN (?) AND published IS ?', product_ids, true)
                       .limit(3)
  end

  def give_away
    Gift.where('limitation > ?', Time.zone.today).each do |gift|
      product_type = gift.product.product_types.order(price: :desc).first
      gifts_products = @line_items.where('product_type_id = ? AND gift_id = ?', product_type.id, gift.id)

      if current_cart.total_price >= gift.amount_target && gifts_products.empty?
        @line_items.create(product_type: product_type, gift_id: gift.id)
      else
        @line_items.where(gift_id: gift.id).destroy_all
      end
    end
  end

  private

  def set_line_items
    @line_items = current_cart.line_items
  end
end
