module ProductsHelper
  def product_ids(object)
    object.line_items.map { |ln| ln.burger_id.present? ? 0 : ln.product_type.product.id }
  end
end
