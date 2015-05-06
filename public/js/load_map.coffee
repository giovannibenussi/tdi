function LoadMap(data, options) {
	var map = L.map('map')
  var end_lat = options['end_lat']
  var end_lon = options['end_lon']
  var start_lat = options['start_lat']
  var start_lon = options['start_lon']

	L.tileLayer('https://{s}.tiles.mapbox.com/v3/{id}/{z}/{x}/{y}.png', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="http://mapbox.com">Mapbox</a>',
		id: 'examples.map-i875mjb7',
	}).addTo(map);

	var greenIcon = L.icon({
	    iconUrl: base_url + 'finish.png',
	    // shadowUrl: 'leaf-shadow.png',

	    iconSize:     [32, 32], // size of the icon
	    shadowSize:   [0, 0], // size of the shadow
	    iconAnchor:   [5, 26], // point of the icon which will correspond to markers location
	    shadowAnchor: [4, 62],  // the same for the shadow
	    popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
	});
	// var polygon = L.polyline(data).addTo(map);
	L.marker([start_lat, start_lon]).addTo(map)
	L.marker([end_lat, end_lon], {icon: greenIcon}).addTo(map)



	center_lat = (start_lat + end_lat) / 2
	center_lon = (start_lon + end_lon) / 2
	map.fitBounds([
	    [start_lat, start_lon],
	    [end_lat, end_lon]
	]);

	min_lat = _.min(start_lat, end_lat)
	min_lon = start_lon < end_lon ? start_lon : end_lon

	max_lat = start_lat > end_lat ? start_lat : end_lat
	max_lon = start_lon > end_lon ? start_lon : end_lon

	// L.marker([-33.5013132 + margen, -70.7413766 - margen]).addTo(map)

	// min_lat =
	// -33.5013132
	// -70.7413766
	// -33.5689855
	// -70.6336521
	L.marker([min_lat, min_lon], {icon: greenIcon}).addTo(map)
	L.marker([max_lat, max_lon], {icon: greenIcon}).addTo(map)

	L.marker([start_lat, start_lon]).addTo(map)
	L.marker([end_lat, end_lon]).addTo(map)

	show_bounds = false
	if (show_bounds) {
		margen = 0.002
		margin_min_lat = min_lat - margen
		margin_min_lon = min_lon - margen

		margin_max_lat = max_lat + margen
		margin_max_lon = max_lon + margen

		var polygon = L.polygon([
		    [margin_min_lat, margin_min_lon],
		    [margin_max_lat, margin_min_lon],
		    [margin_max_lat, margin_max_lon],
		    [margin_min_lat, margin_max_lon],
		]).addTo(map);
	}

	// map.fitBounds([
	    // [min_lat, min_lon],
	    // [max_lat, max_lon]
	// ]);

	var myLines = [{
	    "type": "LineString",
	    "coordinates": data
	}, {
	    "type": "LineString",
	    "coordinates": [[-105, 40], [-110, 45], [-115, 55]]
	}];

	var path_lines = [{
	    "type": "LineString",
	    "coordinates": data
	}/*, {
	    "type": "LineString",
	    "coordinates": data
	}*/];

	var path_style = {
	    "color": "#1E88E5",
	    "weight": 5,
	    "opacity": 0.65
	};

	L.geoJson(path_lines, { style: path_style }).addTo(map);
}
