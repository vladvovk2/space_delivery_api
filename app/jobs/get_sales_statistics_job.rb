class GetSalesStatisticsJob < ApplicationJob
  queue_as :product_sales

  def perform(order)
    increase_sales_count(order)
  end

  private

  # ln eql line_item

  def get_products_ids(order)
    ids = []

    order.line_items.map do |ln|
      ids << ln.product_type.product.id
    end

    ids.uniq
  end

  def increase_sales_count(order)
    product_ids = get_products_ids(order)

    order.line_items.each do |ln|
      product_ids.each do |id|
        next if ln.product_type.product.id.eql? id

        product = ln.product_type.product.active_product_sales.find_or_create_by(passive_id: id)
        sales_count = product.sales_count + 1
        product.update(sales_count: sales_count)
      end
    end
  end
end
