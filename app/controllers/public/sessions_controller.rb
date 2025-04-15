# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :set_genres
  before_action :set_regions

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.

  private

  def set_genres
    @genres = Genre.all
  end

  def set_regions
    @all_region_names = Location.distinct.pluck(:name)
  end

  def after_sign_in_path_for(resource)
    mypage_users_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end
