class ShortestController < ApplicationController
  def index
  	@root_path = ENV["RAILS_RELATIVE_URL_ROOT"]
  	@nombre = "GIovanni"
  	@kml = '[[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]'
  end

  def getShortestRoute
  	@route = '[[-70.5651589, -33.5845709],[-70.5654396, -33.5846502],[-70.5663199, -33.5847003],[-70.5665037, -33.5847191],[-70.5664485, -33.5850722],[-70.5663892, -33.5854515],[-70.5668373, -33.5854689],[-70.5667049, -33.5862947],[-70.5665753, -33.5871029],[-70.5664665, -33.5877812],[-70.5663505, -33.5884897],[-70.5675535, -33.5885686],[-70.5672967, -33.5899116],[-70.5669560, -33.5910857],[-70.5668328, -33.5915106],[-70.5667153, -33.5919155],[-70.5666093, -33.5922809],[-70.5664645, -33.5927800],[-70.5664302, -33.5928981],[-70.5664203, -33.5929323],[-70.5664214, -33.5929656]]'
  	render content_type: 'application/json', layout: false
  	# send_data kml
  end
end
