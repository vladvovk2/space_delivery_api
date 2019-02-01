module DeliveryApi
  module Control
    class LineItemApi < Grape::API
      helpers do
        params :line_item_id do
          requires :id, type: Integer
        end
      end

      resources :line_items do
        get do
          line_items = LineItem.all
          present_with_entities(line_items)
        end

        params do
          use :line_item_id
        end
        post 'increase_quantity/:id' do
          line_item = LineItem.find(params[:id])
          line_item.increase_quantity
          present_with_entities(line_item)
        end

        params do
          use :line_item_id
        end
        post 'reduce_quantity/:id' do
          line_item = LineItem.find(params[:id])
          line_item.reduce_quantity
          present_with_entities(line_item)
        end

        params do
          use :line_item_id
        end
        delete do
          line_item = LineItem.find(params[:id])
          { message: 'Successfully deleted.' } if line_item.destroy
        end
      end
    end
  end
end
