class BlogsController < ApplicationController
  before_action :path_identifier, only: %i[generate_menu download_menu]

  def index; end

  def generate_menu
    path = "#{Rails.root}/public/pdfs/menu_#{@path_identifier}.pdf"
    MenuJob.new.perform(@path_identifier) unless File.exist?(path)
  end

  def download_menu
    send_file "#{Rails.root}/public/pdfs/menu_#{@path_identifier}.pdf",
              type: 'pdf',
              x_sendfile: true
  end

  private

  def path_identifier
    @path_identifier ||= current_user.phone_number.last(7)
  end
end
