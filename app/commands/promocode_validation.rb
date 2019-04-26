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
    return broadcast(:used)     if used?
    return broadcast(:owner)    if user_owner?
    return broadcast(:expired)  if expired?
    return broadcast(:category, promocode.category.title) if cart_include_category?
  end

  def expired?
    promocode.limitation && promocode.limitation < Time.zone.today
  end

  def user_owner?
    user && user.promo_code.id.eql?(promocode.id)
  end

  def used?
    promocode.used
  end

  def cart_include_category?
    cart.product_types.select { |pt| pt.product.category_id.eql? promocode.category_id }.empty? if promocode.category_id
  end
end
