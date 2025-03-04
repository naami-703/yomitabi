class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]

  def top
  end
    
end
