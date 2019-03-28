module CartsHelper
  def current_cart
    if session[:cart_id].blank?
      cart = Cart.create()
      session[:cart_id] = cart.id
    else
      cart = Cart.find(session[:cart_id])
    end
    cart
  end
end
