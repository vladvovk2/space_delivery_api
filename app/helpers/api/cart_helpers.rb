module Api
  module CartHelpers
    def current_cart
      current_user.cart
    end
  end
end
