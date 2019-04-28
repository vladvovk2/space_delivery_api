class LineItemsController < ApplicationController
  before_action :set_line_item,     only: %i[quantity_increase quantity_reduce destroy]
  before_action :set_respond_to_js, only: %i[quantity_increase quantity_reduce destroy]

  def quantity_increase
    @line_item.update(quantity: @line_item.quantity + 1)
  end

  def quantity_reduce
    @line_item.update(quantity: @line_item.quantity - 1) unless @line_item.quantity.eql? 1
  end

  def destroy
    @line_item.destroy
  end

  private

  def set_respond_to_js
    respond_to do |format|
      format.js
    end
  end

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
