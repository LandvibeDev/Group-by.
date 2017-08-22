class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

  def configure_permitted_parameters

    # devise_parameter_sanitizer.permit(:u) do |user_params|
    #   user_params.permit(:email, :password, :password_confirmation , :name , :organization )


    devise_parameter_sanitizer.permit(:sign_up ) do |user_params|
      user_params.permit(:email, :password, :password_confirmation , :name , :organization )
    end

    devise_parameter_sanitizer.permit(:account_update ) do |user_params|
      user_params.permit(:email,:password, :password_confirmation ,:current_password, :name , :organization )
    end

  end


end
