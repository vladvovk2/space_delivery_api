class FavoritesController < ApplicationController
  before_action :set_favorites, only: :make_favorite

  def index
    @favorites = Favorite.includes(product: %i[product_types picture])
                         .where(user_id: current_user.id)
  end

  def make_favorite
    @product = Product.find(params[:id])

    if @favorites.find_by(product_id: @product.id).try(:destroy)
      send_notification "#{@product.title} deleted from favorites"
    elsif @favorites.create(product_id: @product.id)
      send_notification "#{@product.title} add to favorites"
    else
      send_notification "#{@product.title} cant add."
    end

    respond_to { |format| format.js }
  end

  private

  def set_favorites
    @favorites = current_user.favorites
  end
end
