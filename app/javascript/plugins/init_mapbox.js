import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {  // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    // add markers of sellers
    const markers = JSON.parse(mapElement.dataset.markers);

    const addMarkersToMap = (map, markers) => {
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.infoWindow); // add this

        new mapboxgl.Marker()
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup) // add this
          .addTo(map);
      });
    };


   // fit my map to markers
   const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
      markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
      map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
    };

    addMarkersToMap(map, markers);

    //add marker of userloc if it exist
    if (mapElement.dataset.userloc !== '') {
      const userloc  = JSON.parse(mapElement.dataset.userloc);

      new mapboxgl.Marker({ color: '#FF0000' })
          .setLngLat([ userloc[0].lng, userloc[0].lat ])
          .addTo(map);

      markers.push(userloc[0]);
    }
    fitMapToMarkers(map, markers);

  }
}

export { initMapbox };
