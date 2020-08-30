class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name, :kana_first_name, :kana_last_name,
                                                       :birth_date, :prefecture_id])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["MAVIEW_BASIC_USER"] && password == ENV["MAVIEW_BASIC_PASSWORD"]  # 環境変数を読み込む記述に変更
     end
  end
end
