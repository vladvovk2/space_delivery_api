class PromocodeValidation < Rectify::Command
  def initialize(promocode, user, cart)
    @promocode = PromoCode.find_by(code: promocode)
    @user = user
    @cart = cart
  end

  def call
    return broadcast(:blank) if promocode.blank?

    validation_result
  end

  private

  attr_reader :promocode, :user, :cart

  def validation_result
    used?
    user_owner?
    expired?
    cart_include_category?
  end

  def expired?
    message = 'Promocode is expired.'
    return broadcast(:error, message) if promocode.limitation && promocode.limitation < Time.zone.today
  end

  def user_owner?
    message = 'You can`t use your own promocode.'
    return broadcast(:error, message) if user && user.promo_code.id.eql?(promocode.id)
  end

  def used?
    message = 'Promocode already used.'
    return broadcast(:error, message) if promocode.used
  end

  def cart_include_category?
    if promocode.category_id
      message = "The promocode applies only to products in the category: #{promocode.category.title.downcase}. \
      But products in this category are not in the cart"

      return broadcast(:error, message) if cart.product_types.select { |pt| pt.product.category_id.eql? promocode.category_id }.empty?
    end
  end
end
