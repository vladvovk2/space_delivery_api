class DeleteMenuWorker
  include Sidekiq::Worker

  def perform(time)
    path = "#{Rails.root}/public/pdfs/menu_#{time}.pdf"
    File.delete(path) if File.exist?(path)
  end
end
