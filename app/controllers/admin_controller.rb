class AdminController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :check_is_admin

  def dashboard
    # entry format: [number, content, type/color]
    @cards = []

    num_new_payments = Payment.where("created_at < ?", 7.days.ago).count
    @cards << [num_new_payments, "new donations made in the past 7 days", "success"]

    total_new_payments = Payment.where("created_at < ?", 7.days.ago).sum(:amount)
    @cards << [number_to_currency(total_new_payments, precision: 0), "donated in total in the past 7 days", "success"]

    num_org_to_approve = Organization.where("is_approved = ?", false).count
    @cards << [num_org_to_approve, "organizations waiting to be approved", "warning"]

    num_camp_to_approve = CampaignChange.count
    @cards << [num_camp_to_approve, "new/existing campaigns waiting to be approved", "warning"]

    num_active_camp = Campaign.where("is_active = ?", true).count
    @cards << [num_active_camp, "active campaigns currently on the site", "info"]
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
