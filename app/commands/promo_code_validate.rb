class PromoCodeValidate < Rectify::Command
  def initialize(user, promo_code)
    @user = user
    @promo_code = promo_code
  end

  def call
    promo_code_responce
  end

  private

  attr_reader :user, :promo_code

  def promo
    PromoCode.find_by(code: promo_code)
  end

  def promo_code_responce
    return broadcast(:not_exist) unless promo_code_present?
    return broadcast(:owner)     if user_is_owner?
  end

  def promo_code_present?
    promo.present?
  end

  def user_is_owner?
    promo.user_id.eql?(user.id) && promo.invite.eql?(true)
  end
end
