App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $("#notification-messages").removeClass('hidden')
    var notificationContent = $('#notification-messages').append(this.renderNotification(data));
    $('.notification-wrapper').fadeOut(5000);
    return notificationContent;
  },

  renderNotification: function(data) {
    return "<div class='notification-wrapper'>" +
            "<p>" + data.message + "</p></div>";
  }
});