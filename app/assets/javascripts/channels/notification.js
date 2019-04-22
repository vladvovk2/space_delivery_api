App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $("#notification-messages").removeClass('hidden')
    return $('#notification-messages').append(this.renderNotification(data));
  },

  renderNotification: function(data) {
    return "<div class='notification-wrapper'>" +
            "<p>" + data.message + "</p></div>";
  }
});
