module ProductsHelper
  def product_ids(object)
    object.line_items.map { |ln| ln.product_type.product.id }
  end
end
