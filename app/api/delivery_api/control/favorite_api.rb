module DeliveryApi
  module Control
    class FavoriteApi < Grape::API
      resources :favorites do
        before { authorized! }

        get(:list) { @response = current_user.favorites.order(:product_id) }

        route_param :id, type: Integer do
          desc 'Added to favorites form.'
          post :create do
            MakeFavorite.call(current_user, params[:id]) do
              on(:ok)      { present(message: 'Added to favorites.') }
              on(:fail)    { present(message: 'Cant add to favorites.') }
              on(:include) { present(message: 'Already added.') }
            end
          end

          desc 'Deleted from favorites form.'
          delete :destroy do
            favorite = current_user.favorites.find(params[:id])
            { message: 'Deleted from favorites.' } if favorite.destroy
          end
        end
      end
    end
  end
end
