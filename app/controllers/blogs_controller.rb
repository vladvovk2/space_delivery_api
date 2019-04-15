class BlogsController < ApplicationController
  def index; end

  def download_menu
    GenerateMenuWorker.perform_async("current_user")
  end
end
