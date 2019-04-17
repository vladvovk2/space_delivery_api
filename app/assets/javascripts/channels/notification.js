App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $("#notification-messages").removeClass('hidden')
    return $('#notification-messages').append(this.renderNotification(data));
  },

  renderNotification: function(data) {
    return "<p>" + data.message + "</p>";
  }
});
