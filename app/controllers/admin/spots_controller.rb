class Admin::SpotsController < ApplicationController
  before_action :authenticate_admin!

  def index 
    @spots = Spot.all
  end

  def edit
    @spot = Spot.find(params[:id])
  end

  def update
    @spot = Spot.find(params[:id])
    if @spot.update(spot_params)
      redirect_to admin_spots_path, notice: "スポット情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to admin_spots_path
  end

  private

  def spot_params
    params.require(:spot).permit(:name, :address, :spot_image)
  end
  
end

