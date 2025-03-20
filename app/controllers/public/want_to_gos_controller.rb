class Public::WantToGosController < ApplicationController

  def create
    @spot = Spot.find(params[:spot_id])
    want_to_go = current_user.want_to_gos.new(spot_id: @spot.id)
    want_to_go.save
  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    want_to_go = current_user.want_to_gos.find_by(spot_id: @spot.id)
    want_to_go.destroy
  end
  
end
