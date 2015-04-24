  	class Graph
  	  Vertex = Struct.new(:name, :neighbours, :dist, :prev)
  	 
  	  def initialize(graph)
  	    @vertices = Hash.new{|h,k| h[k]=Vertex.new(k,[],Float::INFINITY)}
  	    @edges = {}
  	    graph.each do |(v1, v2, dist)|
  	      @vertices[v1].neighbours << v2
  	      @vertices[v2].neighbours << v1
  	      @edges[[v1, v2]] = @edges[[v2, v1]] = dist
  	    end
  	    @dijkstra_source = nil
  	  end
  	 
  	  def dijkstra(source)
  	    return  if @dijkstra_source == source
  	    q = @vertices.values
  	    q.each do |v|
  	      v.dist = Float::INFINITY
  	      v.prev = nil
  	    end
  	    @vertices[source].dist = 0
  	    until q.empty?
  	      u = q.min_by {|vertex| vertex.dist}
  	      break if u.dist == Float::INFINITY
  	      q.delete(u)
  	      u.neighbours.each do |v|
  	        vv = @vertices[v]
  	        if q.include?(vv)
  	          alt = u.dist + @edges[[u.name, v]]
  	          if alt < vv.dist
  	            vv.dist = alt
  	            vv.prev = u.name
  	          end
  	        end
  	      end
  	    end
  	    @dijkstra_source = source
  	  end
  	 
  	  def shortest_path(source, target)
  	    dijkstra(source)
  	    path = []
  	    u = target
  	    while u
  	      path.unshift(u)
  	      u = @vertices[u].prev
  	    end
  	    return path, @vertices[target].dist
  	  end
  	 
  	  def to_s
  	    "#<%s vertices=%p edges=%p>" % [self.class.name, @vertices.values, @edges] 
  	  end
  	end

class ShortestController < ApplicationController
  def index
  	@root_path = ENV["RAILS_RELATIVE_URL_ROOT"]
  	@nombre = "GIovanni"
  	@kml = '[[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]'
  end

  def getShortestRouteStatic
  	@route = '[[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]'
  	render content_type: 'application/json', layout: false
  end

	def getClosestNode(nodes, start, finish)
		my_node = [start, finish]
		# @route = ''
		min_node = nil
		min_distance = Float::INFINITY
	  	nodes.each do | node |
	  		fit_node = [node[:lat].to_f, node[:lon].to_f, node[:id]]
	  		distance = distance_in_meters(fit_node, my_node)
	  		# @route += node.to_s + " - #{distance}" + "\n"
	  		if distance < min_distance
	  			min_distance = distance
	  			min_node = fit_node
	  		end
	  	end
	  	return min_node
	  	# @route += 'Min: ' + min_node.to_s
    end
  	def distance_in_meters loc1, loc2
  	  rad_per_deg = Math::PI/180  # PI / 180
  	  rkm = 6371                  # Earth radius in kilometers
  	  rm = rkm * 1000             # Radius in meters

  	  dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  	  dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

  	  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  	  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  	  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  	  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  	  rm * c # Delta in meters
  	end
  def closestNode

  	nodes = [[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]
  	client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'tdi')
  	nodes = client[:nodes].find()
	start, finish = -70.5651589, -33.5845709

	# Diinf
	start, finish = -33.4498082, -70.6871985

	closest_node = getClosestNode(nodes, start, finish)
	@route = closest_node[2]

  	render 'getShortestRoute', content_type: 'application/json', layout: false
  end

  def getShortestRoute
  	# @route = '[[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]'
  	require 'builder'
  	require 'nokogiri'

  	def GetNode(nodes_full, id)
  		nodes_full.each do | node_full |
  			# puts node_full
  			if node_full[:id].to_i == id
  				return node_full
  			end
  		end
  	end

  	def GetClosestNode(nodes_full, lat, lon)
  		lat = lat.to_f
  		lon = lon.to_f
  		puts "Distancia entre #{lat}, #{lon}"
  		node = nil
  		min_distance = Float::INFINITY
  		id = -1
  		nodes_full.each do | node_full |
  			# distance = distance_in_meters( [lat, lon], [node_full[:lat].to_f, node_full[:lon].to_f])
  			distance_lat = lat - node_full[:lat].to_f
  			distance_lon = lon - node_full[:lon].to_f
  			distance = Math.sqrt(distance_lat*distance_lat + distance_lon*distance_lon)
  			distance = distance_lon.abs + distance_lat.abs
  			# puts "Distance: #{id} = #{min_distance}"
  			if 0 < distance and distance < min_distance
  				id = node_full[:id]
  				node = node_full
  				min_distance = distance
  			end
  		end
  		return node
  	end

  	def distance_in_meters loc1, loc2
  	  rad_per_deg = Math::PI/180  # PI / 180
  	  rkm = 6371                  # Earth radius in kilometers
  	  rm = rkm * 1000             # Radius in meters

  	  dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
  	  dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

  	  lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
  	  lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }

  	  a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
  	  c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

  	  rm * c # Delta in meters
  	end

  	@doc = Nokogiri::XML(File.read(Rails.root + "app/controllers/data/map.osm"))
  	archivo_salida = 'salida_mapa.kml'



  	client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'tdi')

  	ways = client[:distances].find()
  	nodes_graph = []
  	i = 0
  	ways.each do | way |
  		print "\r#{i}"
  		i += 1
  		nodes_graph << [ way[:node_one], way[:node_two], way[:distance] ]
  		nodes_graph << [ way[:node_two], way[:node_one], way[:distance] ]
  	end

  	g = Graph.new( nodes_graph )

  	# start, stop = 1853732946, 1856129646

	# @route = getClosestNode(nodes, start, finish).to_s
  	nodes_full = client[:nodes].find()

	

  	# diinf
  	# start_lat, start_lon = -33.4498082, -70.6871985

  	start_lat, start_lon = -33.5748042, -70.5708075
  	stop_lat, stop_lon = -33.5839787, -70.5701561

	start_closest_node = getClosestNode(nodes_full, start_lat, start_lon)
	stop_closest_node = getClosestNode(nodes_full, stop_lat, stop_lon)
	
	start = start_closest_node[2].to_i
	stop  = stop_closest_node[2].to_i

  	path, dist = g.shortest_path(start, stop)
  	puts "shortest path from #{start} to #{stop} has cost #{dist}:"
  	puts path.join(" -> ")

  	@route = '['
	path.each do | node_id |
		# search in nodes
		node = client[:nodes].find({ id: node_id.to_s }).limit(1)
		if node.count > 0
			@route += "[#{node.first[:lon]}, #{node.first[:lat]}],"
		end
	end

	@route = @route[0...-1]
	@route += ']'
  	render content_type: 'application/json', layout: false
  end
end
