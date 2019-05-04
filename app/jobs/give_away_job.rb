class GiveAwayJob < ApplicationJob
  queue_as :default

  def perform(cart_id)
    cart = Cart.find(cart_id)
    GiveAway.call(cart)
  end
end
