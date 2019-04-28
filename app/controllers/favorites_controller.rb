class FavoritesController < ApplicationController
  before_action :set_favorites, only: %i[show make_favorite]

  def show; end

  def make_favorite
    @product = Product.find(params[:id])

    if @favorites.find_by(product_id: @product.id).try(:destroy)
      send_notification "#{@product.title} deleted from favorites"
    else
      @favorites.create(product_id: @product.id)
      send_notification "#{@product.title} add to favorites"
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def set_favorites
    @favorites = current_user.favorites
  end
end
