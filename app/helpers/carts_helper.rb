module CartsHelper
  def current_cart
    @cart ||= Cart.includes(line_items: [product_type: :product]).find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  ensure
    @cart
  end
end
