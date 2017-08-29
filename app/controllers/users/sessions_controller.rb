class Users::SessionsController < Devise::SessionsController
  before_action :authenticate_user!

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: params[:user][:email])
    if user
      if user.confirmed_at.blank?
        redirect_to new_user_session_path, :flash => { :error => "Please Confirm the mail authentication." }
      else
        if user.valid_password?(params[:user][:password])
          sign_in_and_redirect user
        else
          redirect_to new_user_session_path,:flash => { :error => "Please check your password." }
        end
      end
    else
      redirect_to new_user_session_path,:flash => { :error => "Please check your email." }
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
