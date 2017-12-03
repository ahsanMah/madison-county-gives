class AdminController < ApplicationController
  before_action :check_is_admin

  def dashboard
  end

  private
    def check_is_admin
      if !(user_signed_in?)
        flash[:warning] = "You need to sign in or sign up before continuing."
        redirect_to new_user_session_path and return
      elsif !(current_user.is_admin?)
        redirect_to root_url and return
      end
    end

end
