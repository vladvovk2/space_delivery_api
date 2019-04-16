class BlogsController < ApplicationController
  def index; end

  def generate_menu
    MenuJob.new.perform
  end

  def download_menu
    send_file "#{Rails.root}/uploads/pdfs/menu_#{}.pdf",
              type: 'application/pdf',
              x_sendfile: true
  end
end
