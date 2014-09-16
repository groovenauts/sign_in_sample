class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_paramters, if: :devise_controller?

  protected

  def configure_permitted_paramters
    # deviseに渡すため、modelに追加したカラムはここでセットしてあげる
    # :sign_up, :sign_in, :account_update の3つがある
    devise_parameter_sanitizer.for(:sign_up) << :role
    devise_parameter_sanitizer.for(:account_update) << :role
  end

end
