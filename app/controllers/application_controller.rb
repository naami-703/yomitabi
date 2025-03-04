class ApplicationController < ActionController::Base

  before_action :authenticate_user!

  # devise利用の機能（ユーザー登録等）が使われる前にonfigure_permitted_parametersメソッドが実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    mypage_users_path
  end

  def after_sign_in_path_for(resource)
    mypage_users_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # ユーザー登録(sign_up)の際に、email)のデータ操作を許可  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
