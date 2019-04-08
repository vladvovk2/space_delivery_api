function initMap2() {
  var lat = document.getElementById('order_place_attributes_latitude').value;
  var lng = document.getElementById('order_place_attributes_longitude').value;

  if (!lat || !lng){
      lat=49.443247;
      lng=32.061894;
      document.getElementById('order_place_attributes_latitude').value = lat;
      document.getElementById('order_place_attributes_longitude').value = lng;
  }
  var myCoords = new google.maps.LatLng(lat, lng);
  var mapOptions = {
    center: myCoords,
    zoom: 14,
    disableDefaultUI: true
  };
  var map = new google.maps.Map(document.getElementById('map2'), mapOptions);
  var marker = new google.maps.Marker({
      position: myCoords,
      animation: google.maps.Animation.DROP,
      map: map,
      draggable: true
  });
  function refreshMarker(){
      var lat = document.getElementById('order_place_attributes_latitude').value;
      var lng = document.getElementById('order_place_attributes_longitude').value;
      var myCoords = new google.maps.LatLng(lat, lng);
      marker.setPosition(myCoords);
      map.setCenter(marker.getPosition());
  }

  document.getElementById('order_place_attributes_latitude').onchange = refreshMarker;
  document.getElementById('order_place_attributes_longitude').onchange = refreshMarker;

  marker.addListener('drag', function() {
      latlng = marker.getPosition();
      newlat=(Math.round(latlng.lat()*1000000))/1000000;
      newlng=(Math.round(latlng.lng()*1000000))/1000000;
      document.getElementById('order_place_attributes_latitude').value = newlat;
      document.getElementById('order_place_attributes_longitude').value = newlng;
  });

  marker.addListener('dragend', function() {
      map.panTo(marker.getPosition());
  });
}