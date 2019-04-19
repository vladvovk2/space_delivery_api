class CategoriesController < ApplicationController
  before_action :set_categories, only: :show
  before_action :path_identifier, only: %i[generate_menu download_menu]

  def show
    @category = Category.includes(products: %i[picture product_types])
                        .where(products: { published: true }).find(params[:id])
  end

  def generate_menu
    MenuJob.new.perform(@path_identifier) unless File.exist?(@path)
  end

  def download_menu
    send_file @path,
              type: 'pdf',
              x_sendfile: true
  end

  private

  def set_categories
    @categories = Category.all
  end

  def path_identifier
    @path_identifier ||= current_user.phone_number.last(7)
    @path = "#{Rails.root}/public/pdfs/menu_#{@path_identifier}.pdf"
  end
end
