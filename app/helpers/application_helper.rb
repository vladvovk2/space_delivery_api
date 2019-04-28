module ApplicationHelper
  include UsersHelper
  include CartsHelper

  def send_notification(message)
    ActionCable.server.broadcast :notifiations, message: message
  end
end
