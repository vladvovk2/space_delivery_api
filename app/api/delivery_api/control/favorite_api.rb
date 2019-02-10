module DeliveryApi
  module Control
    class FavoriteApi < Grape::API
      resources :favorites do
        get do
          favorites = Favorite.where(user_id: current_user.id).order(:product_id)
        end

        params do
          requires :id, type: Integer, desc: 'Product ID.'
        end
        post :create do
          favorite = current_user.favorites.create(product_id: declared_params[:id])
        end

        delete ':id' do
          favorite = Favorite.find(params[:id])
          { message: 'Successfully deleted from favorites.' } if favorite.destroy
        end
      end
    end
  end
end