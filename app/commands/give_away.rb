class GiveAway < Rectify::Command
  VALID_GIFTS_TYPES = {
    'n+1' => :quantity_type,
    'target' => :target_type
  }.freeze

  def initialize(cart)
    @cart       = cart
    @gifts      = Gift.includes(:product).where('limitation > ?', Time.zone.today)
    @line_items = cart.line_items.where(burger_id: nil)
  end

  def call
    action_with_line_item
  end

  private

  attr_reader :cart, :gifts
  attr_accessor :line_items

  def action_with_line_item
    gifts.each do |gift|
      product_type = product_type(gift)
      gift_products = gift_products(product_type, gift)

      send(VALID_GIFTS_TYPES[gift.gift_type], gift, product_type, gift_products)
    end
  end

  def quantity_type(gift, product_type, gift_products)
    gift_product = line_items.detect { |ln| ln.product_type.product.id.eql?(gift.product.id) && ln.quantity >= gift.quantity }

    create_or_delete_if(product_type, gift) { gift_product.present? && gift_products.empty? }
  end

  def target_type(gift, product_type, gift_products)
    create_or_delete_if(product_type, gift) { cart.total_price >= gift.amount_target && gift_products.empty? }
  end

  def create_or_delete_if(product_type, gift)
    if yield
      line_items.create(product_type: product_type, gift_id: gift.id)
    else
      line_items.where(gift_id: gift.id).destroy_all
    end
  end

  def product_type(gift)
    gift.product.product_types.order(price: :asc).first
  end

  def gift_products(product_type, gift)
    line_items.where('product_type_id = ? AND gift_id = ?', product_type.id, gift.id)
  end
end
