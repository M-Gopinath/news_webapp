# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :html, :js
  skip_before_action :authenticate_admin!, only: [:create, :sign_out]
  before_action :clear_xhr_flash, only: [:new]

  def clear_xhr_flash
    flash.clear
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    @login = false
    @error = false
    @admin = Admin.find_by(email: params[:admin][:email])
    respond_to do |format|
      if @admin.present?
        if @admin.valid_password?(params[:admin][:password])
          sign_in(@admin)
          @login = true
          flash[:notice] = "Sign in successfully"
          format.html {redirect_to root_path }
          format.js
          format.json {render json: {result: true, info: "Sign in successfully"}}
        else
          @error = "Invalid Email/Password"
          flash[:danger] = @error
          format.html {render "new"}
          format.js
          format.json {render json: {result: false, error: "Invalid Email/Password"}}
        end
      else
        @error = "User not found"
        flash[:danger] = @error
        format.html {render "new"}
        format.js
        format.json {render json: {result: false, error: "User not found"}}
      end
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
