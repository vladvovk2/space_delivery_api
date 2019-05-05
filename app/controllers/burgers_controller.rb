class BurgersController < ApplicationController
  def new
    @burger = Burger.new
    @ingredient_types = Ingredient.includes(:picture).all.group_by(&:ingredient_type)
  end

  def create
    @burger = Burger.new
  end
end
