class BurgersController < ApplicationController
  def new
    @burger = Burger.new
    @ingredient_types = Ingredient.includes(:picture).all.group_by(&:ingredient_type)
  end

  def create
    @burger = Burger.new
    ids = []
    params[:burger].each { |key, value| ids.push key.to_i unless value.to_i.zero? }
    ids.each { |id| @burger.components.build(ingredient_id: id) }

    if @burger.save
      current_cart.line_items.create(burger_id: @burger.id)
      redirect_to current_cart
    else
      render :new
    end
  end
end
