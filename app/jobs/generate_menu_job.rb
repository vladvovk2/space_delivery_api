class GenerateMenuJob < ApplicationJob
  queue_as :pdf

  def perform(time)
    generate_pdf(time)
  end

  def generate_pdf(time)
    Prawn::Document.generate("public/pdfs/menu_#{time}.pdf") do |pdf|
      Category.includes(products: :product_types).all.each do |category|
        pdf.text "Category: #{category.title}", align: :center, size: 20
        category.products.each do |product|
          pdf.text "Product: #{product.title}", size: 15
          product.product_types.each do |pt|
            pdf.text "proportion: #{pt.proportion}, price: #{pt.price}, weight: #{pt.weight}", size: 10
          end
          pdf.text '-' * 50
        end
      end
      pdf.render
    end
  end
end
