class ApplicationController < ActionController::Base
  before_action :sign_up_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      admin_members_path
    else
      member_path(current_member.id)
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end


  private

    def sign_up_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:first_name,:last_name,:nickname,:introduction,:start_date,:profile_image])
    end

end
