class ApplicationController < ActionController::Base
  before_action :set_genres
  before_action :set_locations

  private

  def set_genres
    @genres = Genre.all
  end

  def set_locations
    @locations = Location.all
  end
end
