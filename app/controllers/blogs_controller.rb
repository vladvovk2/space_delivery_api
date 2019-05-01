class BlogsController < ApplicationController
  def index
    @posts = Blog.order(created_at: :desc).includes(:picture).all
  end
end
