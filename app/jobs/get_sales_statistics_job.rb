class GetSalesStatisticsJob < ApplicationJob
  queue_as :product_sales

  def perform(order)
    increase_sales_count(order)
  end

  private

  def get_products_ids(order)
    ids = []

    # ln eql line_item
    order.line_items.map do |ln|
      ids << ln.product_type.product.id
    end

    ids.uniq
  end

  def increase_sales_count(order)
    product_ids = get_products_ids(order)
    products = Product.find(product_ids)

    products.each do |product|
      product_ids.each do |id|
        next unless product.id != id

        set_of_products = product.active_product_sales.find_or_initialize_by(passive_id: id)
        set_of_products.sales_count += 1
        set_of_products.save
      end
    end
  end
end
