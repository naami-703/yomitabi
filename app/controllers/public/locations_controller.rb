class Public::LocationsController < ApplicationController

  def show
    @location = Location.find(params[:id])
    spots = @location.spots.includes(:want_to_gos, :wents)

    if params[:new]
      @spots = spots.order(created_at: :desc).page(params[:page])
    elsif params[:old]
      @spots = spots.order(created_at: :asc).page(params[:page])
    elsif params[:want_to_go]
      sorted_spots = spots.sort_by { |spot| -spot.want_to_gos.size }
      @spots = Kaminari.paginate_array(sorted_spots).page(params[:page])
    elsif params[:went]
      sorted_spots = spots.sort_by { |spot| -spot.wents.size }
      @spots = Kaminari.paginate_array(sorted_spots).page(params[:page])
    else
      @spots = spots.page(params[:page])
    end
  end
  
end
