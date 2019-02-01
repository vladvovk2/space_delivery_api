module Api
  module CartHelpers
    def current_cart
      if session[:cart_id].blank?
        @cart = Cart.create
        session[:cart_id] = @cart.id
      else
        @cart = Cart.find(session[:cart_id])
      end
      @cart
    end

    def destroy_cart
      current_cart.destroy
      session[:cart_id] = nil
    end
  end
end
