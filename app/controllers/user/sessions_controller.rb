# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  before_action :member_states, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

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

  protected
    def member_states
      @member = Member.find_by(email: params[:member][:email])

      return if !@member

      if @member.valid_password?(params[:member][:password]) && (@member.is_active == false)
        flash[:notice] = "このアカウントは退会済みです"
        redirect_to new_member_registration_path
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
