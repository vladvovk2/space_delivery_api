module DeliveryApi
  module Control
    class FavoriteApi < Grape::API
      resources :favorites do
        get do
          favorites = Favorite.where(user_id: current_user.id).order(:product_id)
          present_with_entities(favorites)
        end

        params do
          requires :id, type: Integer, desc: 'Product ID.'
        end
        post :create do
          MakeFavorite.call(current_user, declared_params[:id]) do
            on(:include){ present(message: 'Already added.') }
            on(:ok) { present(message: 'Successfully added to Favorites.') }
            on(:fail){ present(message: 'Cant add to favorites.') }
          end
        end

        delete ':id' do
          favorite = Favorite.find(params[:id])
          { message: 'Successfully deleted from favorites.' } if favorite.destroy
        end
      end
    end
  end
end