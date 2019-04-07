function openDetails(evt, tabContentNum) {
  // Declare all variables
  var i, tabcontent, tablinks;
  var product = document.getElementById(tabContentNum).parentElement;

  // Get all elements with class="tabcontent" and hide them
  tabcontent = product.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }

  // Get all elements with class="tablinks" and remove the class "active"
  tablinks = product.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }

  // Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(tabContentNum).style.display = "flex";
  evt.currentTarget.className += " active";
}