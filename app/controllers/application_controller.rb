class ApplicationController < ActionController::Base
  before_action :set_category

  private

  def set_category
    @cate ||= Category.first
  end
end
