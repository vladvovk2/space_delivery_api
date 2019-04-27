module CartsHelper
  def current_cart
    @cart ||= Cart.includes(line_items: :product_type).where(line_items: { gift_id: nil }).find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  ensure
    @cart
  end
end
