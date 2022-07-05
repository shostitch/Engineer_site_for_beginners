class ApplicationController < ActionController::Base
  before_action :sign_up_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    member_path(current_member)
  end


  private

    def sign_up_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:first_name,:last_name,:nickname,:introduction])
    end

end
