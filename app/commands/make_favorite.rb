class MakeFavorite < Rectify::Command
  def initialize(user, product_id)
    @user = user
    @product_id = product_id
  end

  def call
    return broadcast(:include) if user_have_favorite?

    favorite_responce
  end

  private

  attr_reader :user, :product_id

  def favorite_responce
    favorite = current_user.favorites.build(product_id: product_id)
    favorite.save ? broadcast(:ok) : broadcast(:fail)
  end

  def user_have_favorite?
    current_user.favorites.where(product_id: product_id).exists?
  end
end
