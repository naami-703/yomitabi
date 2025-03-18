class Admin::LocationsController < ApplicationController
  before_action :authenticate_admin!

  def index 
    @locations = Location.all
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to admin_locations_path, notice: "地域を登録しました。"
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :index
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update(location_params)
      redirect_to admin_locations_path, notice: "所在地情報を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to admin_locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :address_prefectures)
  end
  
end
