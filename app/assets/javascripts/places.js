function initMap(lat, lng) {
  var myCoords = new google.maps.LatLng(lat, lng);

  var mapOptions = {
  center: myCoords,
  zoom: 14
  };

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  var marker = new google.maps.Marker({
    position: myCoords,
    map: map
  });
}

function initMap2() {
  var lat = document.getElementById('place_latitude').value;
  var lng = document.getElementById('place_longitude').value;

  if (!lat || !lng){
      lat=49.443247;
      lng=32.061894;
      document.getElementById('place_latitude').value = lat;
      document.getElementById('place_longitude').value = lng;
  }
  var myCoords = new google.maps.LatLng(lat, lng);
  var mapOptions = {
  center: myCoords,
  zoom: 14
  };
  var map = new google.maps.Map(document.getElementById('map2'), mapOptions);
  var marker = new google.maps.Marker({
      position: myCoords,
      animation: google.maps.Animation.DROP,
      map: map,
      draggable: true
  });
  function refreshMarker(){
      var lat = document.getElementById('place_latitude').value;
      var lng = document.getElementById('place_longitude').value;
      var myCoords = new google.maps.LatLng(lat, lng);
      marker.setPosition(myCoords);
      map.setCenter(marker.getPosition());
  }

  document.getElementById('place_latitude').onchange = refreshMarker;
  document.getElementById('place_longitude').onchange = refreshMarker;

  marker.addListener('drag', function() {
      latlng = marker.getPosition();
      newlat=(Math.round(latlng.lat()*1000000))/1000000;
      newlng=(Math.round(latlng.lng()*1000000))/1000000;
      document.getElementById('place_latitude').value = newlat;
      document.getElementById('place_longitude').value = newlng;
  });

  marker.addListener('dragend', function() {
      map.panTo(marker.getPosition());
  });
}