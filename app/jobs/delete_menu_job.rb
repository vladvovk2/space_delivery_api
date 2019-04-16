class DeleteMenuJob < ApplicationJob
  queue_as :pdf

  def perform(time)
    path = "#{Rails.root}/public/pdfs/menu_#{time}.pdf"
    File.delete(path) if File.exist?(path)
  end
end
