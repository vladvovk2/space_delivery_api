class PromocodeValidation < Rectify::Command
  def initialize(promocode, user)
    @promocode = PromoCode.find_by(code: promocode)
    @user = user
  end

  def call
    validation_result
  end

  private

  attr_reader :promocode, :user

  def validation_result
    return broadcast(:blank)   if promocode.blank?
    return broadcast(:expired) if expired?
    return broadcast(:owner)   if user_owner?
    return broadcast(:used)    if used?
  end

  def expired?
    promocode.limitation.present? && promocode.limitation < Time.zone.today
  end

  def user_owner?
    user.present? && user.promo_code.id.eql?(promocode.id)
  end

  def used?
    promocode.used?
  end
end
