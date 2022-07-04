class ApplicationController < ActionController::Base
  before_action :sign_up_parameters, if: :devise_controller?


  private

    def sign_up_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:first_name,:last_name,:nickname,:introduction])
    end

end
