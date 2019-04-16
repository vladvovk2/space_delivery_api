$(document).on('turbolinks:load', function(){
  var timeOut;

  $(".profile").mouseleave(function() {
    timeOut = setTimeout(function() {
     $(".profile").css("background-color", "transparent");
     $(".profile").css("border-color", "transparent");
     $(".profile .content").css("visibility", "visible");
    }, 305);
  });
  $(".profile, .profile .nav-icon, .profile .content").mouseenter(function() {
    clearTimeout(timeOut);
    $(".profile").css("background-color", "rgba(77, 77, 77, 0.705)");
    $(".profile").css("border", "1px solid #ffffff");
    $(".profile").css("border-bottom-color", "transparent");
    $(".profile a .content").css("visibility", "hidden");
  });
});