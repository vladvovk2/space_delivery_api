function initMap2() {
  var lat = document.getElementById('order_place_attributes_latitude').value;
  var lng = document.getElementById('order_place_attributes_longitude').value;
  var styles = [
    {
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "elementType": "labels.icon",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#212121"
        }
      ]
    },
    {
      "featureType": "administrative",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "administrative.country",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#9e9e9e"
        }
      ]
    },
    {
      "featureType": "administrative.land_parcel",
      "stylers": [
        {
          "visibility": "off"
        }
      ]
    },
    {
      "featureType": "administrative.locality",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#bdbdbd"
        }
      ]
    },
    {
      "featureType": "poi",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#181818"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "poi.park",
      "elementType": "labels.text.stroke",
      "stylers": [
        {
          "color": "#1b1b1b"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "geometry.fill",
      "stylers": [
        {
          "color": "#2c2c2c"
        }
      ]
    },
    {
      "featureType": "road",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#8a8a8a"
        }
      ]
    },
    {
      "featureType": "road.arterial",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#373737"
        }
      ]
    },
    {
      "featureType": "road.highway",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#3c3c3c"
        }
      ]
    },
    {
      "featureType": "road.highway.controlled_access",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#4e4e4e"
        }
      ]
    },
    {
      "featureType": "road.local",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#616161"
        }
      ]
    },
    {
      "featureType": "transit",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#757575"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [
        {
          "color": "#000000"
        }
      ]
    },
    {
      "featureType": "water",
      "elementType": "labels.text.fill",
      "stylers": [
        {
          "color": "#3d3d3d"
        }
      ]
    }
  ]

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
    disableDefaultUI: true,
    styles: styles
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

$(document).on('turbolinks:load', function () {
  $('.name-input').attr('maxlength', '21');
  $('.user-number-input').attr('maxlength', '9');
  $('.promocode-input').attr('maxlength', '21');
  $('.description-input').attr('maxlength', '255');
});