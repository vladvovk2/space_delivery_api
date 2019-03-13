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

        desc 'Faforites list' do
          detail <<-NOTE
            Make a query for favorites.
            Returns an array of all favorites belonging to the current user.
          NOTE
        end
        get do
          favorites = current_user.favorite_records
          present favorites, with: DeliveryApi::Entities::FavoriteResponce
        end

        route_param :product_id, type: Integer do
          desc 'Make product favorite'
          post do
            return present(message: 'Already added') if favorite?

            favorite = current_user.favorites.build(product_id: declared_params[:product_id])
            favorite.save ? present(message: 'Added.') : error!(favorite.errors.messages, 422)
          end
        end

        route_param :favorite_id, type: Integer do
          desc 'Deleted from favorites.'
          delete do
            favorite = current_user.favorite_records.find(params[:favorite_id])
            present(message: 'Deleted.') if favorite.destroy
          end
        end
      end
    end
  end
end
