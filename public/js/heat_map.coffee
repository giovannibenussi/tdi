function LoadHeatMap(data) {
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
    layers: [baseLayer, heatmapLayer]
  });

  heatmapLayer.setData(testData);
}
