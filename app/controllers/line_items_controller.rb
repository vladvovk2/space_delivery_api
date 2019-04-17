class LineItemsController < ApplicationController
  before_action :set_line_item, only: %i[quantity_increase quantity_reduce destroy]

  def quantity_increase
    @line_item.quantity += 1
    ActionCable.server.broadcast :notifiations, message: 'quantity increase' if @line_item.save

    respond_to do |format|
      format.js
    end
  end

  def quantity_reduce
    unless @line_item.quantity.eql? 1
      @line_item.quantity -= 1

      ActionCable.server.broadcast :notifiations, message: 'quantity reduce' if @line_item.save
    end

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end
end
