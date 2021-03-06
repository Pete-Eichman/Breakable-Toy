$( document ).ready(function(){
  $('#submit').on('click', function (){
    var request = $.ajax({
      method: "GET",
      url: "/parking_passes",
      data: { parking_pass: "parking_pass"}
    }).done(function(data){
      for(var i = 0; i < data.length; i++){
        var marker = new google.maps.Marker({
          map: window.map,
          position: {lat: parseFloat(data[i].lat), lng: parseFloat(data[i].lng) }
        });
        let id = data[i].id;
        let price_per_hour = data[i].price_per_hour;
        let address = data[i].address;
        var passInfoWindow =  new google.maps.InfoWindow({
          content: `Price/Hour: $${price_per_hour}`
        });
        google.maps.event.addListener(marker, 'click', function() {
          window.location.href = `/parking_passes/${id}`;
        });
        google.maps.event.addListener(marker, 'mouseover', function() {
          passInfoWindow.open(map, this)
        });
        google.maps.event.addListener(marker, 'mouseout', function() {
          passInfoWindow.close();
        });
      }
    })
  });
})
function initMap() {
  window.map = new google.maps.Map(document.getElementById('map'), {
    zoom: 19,
    center: {lat: 42.3515662, lng: -71.0613815}
  });
  var geocoder = new google.maps.Geocoder();
  document.getElementById('submit').addEventListener('click', function() {
    geocodeAddress(geocoder, window.map);
  });
}
function geocodeAddress(geocoder, resultsMap) {
  var address = document.getElementById('address').value;
  geocoder.geocode({'address': address}, function(results, status) {
    if (status === 'OK') {
      resultsMap.setCenter(results[0].geometry.location);
      var marker = new google.maps.Marker({
        map: resultsMap,
        position: results[0].geometry.location
      });
      var infoWindow =  new google.maps.InfoWindow({
        content: 'Your Destination',
      });
      google.maps.event.addListener(marker, 'mouseover', function() {
        infoWindow.open(map, this)
      });
      google.maps.event.addListener(marker, 'mouseout', function() {
        infoWindow.close();
      });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}
