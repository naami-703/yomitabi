class Public::LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    @spots = @location.spots
  end
  
end
