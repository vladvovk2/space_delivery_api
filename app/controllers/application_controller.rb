class ApplicationController < ActionController::Base
  include UsersHelper

  before_action :set_category

  private

  def set_category
    @cate ||= Category.first
  end
end
