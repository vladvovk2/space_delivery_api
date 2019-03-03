module DeliveryApi
  module Controllers
    class FavoriteApi < Root
      resources :favorites do
        before { authorized! }

        get do
          favorites = current_user.favorite_records
          present favorites, with: DeliveryApi::Entities::FavoriteResponce
        end

        route_param :id, type: Integer do
          desc 'Added to favorites form.'
          post do
            MakeFavorite.call(current_user, params[:id]) do
              on(:ok)      { present(message: 'Added to favorites.') }
              on(:fail)    { present(message: 'Cant add to favorites.') }
              on(:include) { present(message: 'Already added.') }
            end
          end

          desc 'Deleted from favorites form.'
          delete do
            favorite = current_user.favorite_records.find(params[:id])
            present(message: 'Deleted.') if favorite.destroy
          end
        end
      end
    end
  end
end
