App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $("#notification-messages").removeClass('hidden')
    var notificationContent = $('#notification-messages').append(this.renderNotification(data));
    var notificationWrapper = $('.notification-wrapper:last-child');
    
    setTimeout(function() {
      notificationWrapper.animate({opacity: 0.1}, 2250, function() {
          notificationWrapper.css('opacity', '0');
          notificationWrapper.hide(500);
      });
    }, 1000);  

    return notificationContent;
  },

  renderNotification: function(data) {
    return "<div class='notification-wrapper'>" +
            "<p>" + data.message + "</p></div>";
  }
});