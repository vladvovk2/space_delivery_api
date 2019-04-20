class GetSalesStatisticsJob < ApplicationJob
  queue_as :product_sales

  def perform(ids)
    products = Product.where(id: ids)

    products.each do |product|
      (ids - [product.id]).each do |id|
        sales = product.active_product_sales.find_or_initialize_by(passive_id: id)
        sales.update(sales_count: sales.sales_count.to_i + 1)
      end
    end
  end
end
