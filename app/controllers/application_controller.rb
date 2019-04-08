class ApplicationController < ActionController::Base
  include UsersHelper
  include CartsHelper

  before_action :set_category

  private

  def set_category
    @cate ||= Category.first
  end
end
