class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from :notifiations
  end

  def unsubscribed; end
end
