class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  belongs_to :user

  validates :first_name, :last_name, presence: true, length: { in: 2..20 }
  validates :user_number,
            presence: true,
            length: { is: 9 },
            numericality: { only_integer: true }
  validates :description, allow_nil: true, length: { in: 2..250 }
  validates :address, :delivery_type, :pay_type, presence: true

  def get_product(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      line_items.push(line_item)
    end
  end

  private

  before_update :charge_bonuses_to_promo_code_owner

  def charge_bonuses_to_promo_code_owner
    validation_conditions = status_changed? && (status.eql? true) && promo_code
    ChargeBonusesJob.perform_later(promo_code) if validation_conditions
  end
end
