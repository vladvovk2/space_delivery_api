$( document ).on('turbolinks:load', function() {
  if ($('body').outerHeight() > $('.main').outerHeight()) {
    var footerTopMargin = $('body').outerHeight() -
                        ( $('.main').outerHeight() +
                          $('.footer').outerHeight() );
    $('.footer').css('margin-top', footerTopMargin);
  }
});