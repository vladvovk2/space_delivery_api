module DeliveryApi
  module Control
    class LineItemApi < Grape::API
      resources :line_items do
        get do
          line_items = LineItem.all
          present_with_entities(line_items)
        end

        params do
          requires :quantity, type: Integer
        end
        patch ':id/quantity' do
          line_item = LineItem.find(params[:id])
          line_item.change_quantity([:quantity])
          present_with_entities(line_item)
        end

        delete ':id' do
          line_item = LineItem.find(params[:id])
          { message: 'Successfully deleted.' } if line_item.destroy
        end
      end
    end
  end
end
