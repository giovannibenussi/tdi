class ShortestController < ApplicationController
  def index
  	@root_path = ENV["RAILS_RELATIVE_URL_ROOT"]
  	@nombre = "GIovanni"
  end
end
