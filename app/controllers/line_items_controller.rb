class LineItemsController < ApplicationController
  before_action :set_line_item,     only: %i[quantity_increase quantity_reduce destroy]
  before_action :set_quantity,      only: %i[quantity_increase quantity_reduce]
  before_action :set_respond_to_js, only: %i[quantity_increase quantity_reduce destroy]

  def quantity_increase
    @line_item.update(quantity: @quantity + 1)
  end

  def quantity_reduce
    @line_item.update(quantity: @quantity - 1) unless @quantity.eql? 1
  end

  def destroy
    if @line_item.per_bonuses
      current_user.user_balance.tap do |u|
        u.balance += @line_item.total_price
        send_notification "Return #{@line_item.total_price} bonuses to your balance." if u.save
      end
    end

    @line_item.destroy
  end

  private

  def set_respond_to_js
    respond_to { |format| format.js }
  end

  def set_quantity
    @quantity = @line_item.quantity
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
