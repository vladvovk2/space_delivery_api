module DeliveryApi
  module Controllers
    class FavoriteApi < Root
      helpers do
        def favorite?
          current_user.favorite_records.where(product_id: params[:product_id]).exists?
        end
      end

      resources :favorites do
        before { authenticate! }

        get do
          favorites = current_user.favorite_records
          present favorites, with: DeliveryApi::Entities::FavoriteResponce
        end

        route_param :product_id, type: Integer do
          desc 'Added to favorites form.'
          post do
            return present(message: 'Already added') if favorite?

            favorite = current_user.favorites.build(product_id: declared_params[:product_id])
            if favorite.save
              present(message: 'Added.')
            else
              error!(favorite.errors.messages, 422)
            end
          end
        end

        route_param :favorite_id, type: Integer do
          desc 'Deleted from favorites form.'
          delete do
            favorite = current_user.favorite_records.find(params[:favorite_id])
            present(message: 'Deleted.') if favorite.destroy
          end
        end
      end
    end
  end
end
