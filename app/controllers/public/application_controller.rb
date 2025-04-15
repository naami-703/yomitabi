class Public::ApplicationController < ::ApplicationController
  before_action :set_genres
  before_action :set_regions

  private

  def set_genres
    @genres = Genre.all
  end

  def set_regions
    @all_region_names = Location.distinct.pluck(:name)
  end

end