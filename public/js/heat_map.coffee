function LoadHeatMap(data, options) {
    // custom_start_date         = moment(options['custom_start_date']).add(options['custom_start_date'], 'seconds')
    console.log("Fecha: " + options['custom_start_date'])

    custom_start_date         = moment(options['custom_start_date'])
    custom_start_date_millis  = custom_start_date.valueOf()

    custom_end_date         = moment(options['custom_end_date'])
    custom_end_date_millis  = custom_end_date.valueOf()

  var data = _.filter(data, function(element) {
      element_start_date        = moment(element['start_date'])
      element_start_date_millis = moment(element['start_date']).valueOf()
      // 'isBetween' devuelve falso si el valor es igual a uno de los limites
      return  element_start_date.isBetween(custom_start_date, custom_end_date)
  })

  console.log(data.length + "Alertas desde el " + custom_start_date.format('LLL') + " hasta el " + custom_end_date.format('LLL'))

  if( data.length > 0 ) {
      var lats = _.pluck(data, 'lat')
      var lons = _.pluck(data, 'lng')
      var min_lat = _.min(lats)
      var max_lat = _.max(lats)
      var min_lon = _.min(lons)
      var max_lon = _.max(lons)

      var lat_center = (max_lat + min_lat) / 2
      var lon_center = (max_lon + min_lon) / 2
      var map = new L.Map('map', {
        center: new L.LatLng(lat_center, lon_center),
        zoom: 12,
      });

      var testData = {
        data: data
      };

      var baseLayer = L.tileLayer(
        'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
          attribution: '...',
          maxZoom: 18
        }
      );

      var cfg = {
        radius: 20,
        maxOpacity: .8,
        scaleRadius: false,
        useLocalExtrema: true,
        latField: 'lat',
        lngField: 'lng',
        valueField: 'count'
      };

      var heatmapLayer = new HeatmapOverlay(cfg);

      map.addLayer(baseLayer);
      map.addLayer(heatmapLayer);
      heatmapLayer.setData(testData);
  } else {
      console.log("Cargando mapa...")
      var map = L.map('map').setView([-33.683834, -70.683387], 12);
      L.tileLayer(
        'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',{
          attribution: '...',
          maxZoom: 18
        }
      ).addTo(map);
  }
  return map
}
