class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:update, :destroy]

  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'LineItem was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @line_item.destroy
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:quantity)
  end
end
