module DeliveryApi
  module Control
    class ProductApi < Grape::API
      helpers do
        params :products_params do 
          requires :product, type: Hash do
            requires :title,       type: String,  desc: 'Product title.'
            requires :description, type: String,  desc: 'Product description.'
            requires :price,       type: Integer, desc: 'Product price'
          end
        end
        params :product_id do
          requires :id, type: Integer, desc: 'Product ID.'
        end
      end

      resources :products do
        get 'list' do
          products = Product.all
          present_with_entities(products)
        end

        params do
          use :products_params
        end
        post 'create' do 
          product = Product.create(declared_params[:product])
          present_with_entities(product)
        end

        params do
          use :products_params
          use :product_id
        end
        post 'update/:id' do
          product = Product.find(params[:id])
          product.update(declared_params[:product])
          present_with_entities(product)
        end

        params do
          use :product_id
        end
        get 'show/:id' do 
          product = Product.find(params[:id])
          present_with_entities(product)
        end

        params do
          use :product_id
        end
        delete 'delete/:id' do
          product = Product.find(params[:id])
          if product.destroy
            { message: 'Product deleted' }
          else
            error!(product.errors, 404)
          end
        end
      end
    end
  end
end