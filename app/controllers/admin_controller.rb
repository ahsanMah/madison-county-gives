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

    @campaign_changes = CampaignChange.all
  end

  def campaign_approval
    campaign_change = CampaignChange.find(params[:campaign_change_id])
    action = campaign_change.action
    campaign_id = campaign_change.campaign_id
    if action == "DELETE"
      if !campaign_id && Campaign.destroy(campaign_id)
        flash[:notice] = "Campaign \"#{campaign_change.name}\ has been removed form the listing."
      else
        flash[:error] = "We were unable to delete \"#{campaign_change.name}\. " + Campaign.find(campaign_id).errors.full_messages.join(". ")
      end
    else
      campaign = ((action == "CREATE")? Campaign.new : Campaign.find(campaign_id))
      campaign_change.attributes.each do |key, val|
        if key.to_s != "id" && campaign.has_attribute?(key)
          campaign[key] = val
        end
      end
      if campaign.save
        flash[:notice] = "Campaign has been successfully approved!"
        if !campaign_change.destroy
          flash[:error] = "The corresponding campaign request failed to delete. Please manually delete the 'campaign_change', #{campaign_change.name}"
        end
      else
        flash[:error] = "Oops! We failed to approve this campaign. " + campaign.errors.full_messages.join(". ")
      end
    end
    redirect_to admin_path and return
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
