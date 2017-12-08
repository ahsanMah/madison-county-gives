class AdminController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :check_is_admin

  def dashboard
    @unapproved_organizations = Organization.where("is_approved = ?", false)
    @campaign_changes = CampaignChange.all
    @approved_organizations = Organization.where("is_approved = ?", true).includes(:campaigns)
  end

  def organization_approval
    org = Organization.find(params[:organization_id])
    org.is_approved = true
    if org.save
      flash[:notice] = "Organization has been successfully approved!"
    else
      flash[:error] = "Oops! We failed to approve this organization. " + org.errors.full_messages.join(". ")
    end
    redirect_to admin_path and return
  end

  def campaign_approval
    campaign_change = CampaignChange.find(params[:campaign_change_id])
    action = campaign_change.action
    campaign_id = campaign_change.campaign_id
    if action == "DELETE"
      if Campaign.destroy(campaign_id)
        flash[:notice] = "Campaign \"#{campaign_change.name}\" has been removed form the listing."
        if !campaign_change.destroy
          flash[:error] = "The corresponding delete request failed to get removed. Please manually delete the 'campaign_change', #{campaign_change.name}"
        end
      else
        flash[:error] = "We were unable to delete \"#{campaign_change.name}.\" " + Campaign.find(campaign_id).errors.full_messages.join(". ")
      end
    else
      campaign = ((action == "CREATE")? Campaign.new : Campaign.find(campaign_id))
      campaign_change.attributes.each do |key, val|
        if key.to_s != "id" && campaign.has_attribute?(key)
          campaign[key] = val
        end
        campaign.image = campaign_change.image
      end
      campaign[:is_active] = (action == "UPDATE")? campaign[:is_active]: false
      campaign[:is_featured] = (action == "UPDATE")? campaign[:is_featured]: false
      if params[:activate]
        campaign[:is_active] = true
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
