class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  protected
    def after_sign_in_path_for(resource)
      if current_user.organization
        organization_path current_user.organization.id
      else
        new_organization_path
      end
    end
end
