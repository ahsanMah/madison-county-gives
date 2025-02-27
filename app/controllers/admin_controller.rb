class AdminController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :check_is_admin

  def dashboard
    @unapproved_organizations = Organization.where("is_approved = ?", false)
    @campaign_changes = CampaignChange.all
    @active_campaigns = Campaign.where("is_active = ?", true)
    @status_update = StatusUpdate.new
    @approved_organizations = Organization.where("is_approved = ?", true).includes(:campaigns)
    @payment = Payment.new
  end

  def organization_approval
    org = Organization.find(params[:organization_id])
    org.is_approved = true
    if org.save
      flash[:notice] = "Organization has been successfully approved!"
      NotificationMailer.organization_approved_email(org).deliver_now
    else
      flash[:error] = "Oops! We failed to approve this organization. " + org.errors.full_messages.join(". ")
    end
    redirect_to admin_path and return
  end

  def campaign_approval
    campaign_change = CampaignChange.find(params[:campaign_change_id])
    action = campaign_change.action
    campaign_id = campaign_change.campaign_id
    test_env = params[:test_env]

    if action == "DELETE"
      if Campaign.destroy(campaign_id)
        flash[:notice] = "Campaign \"#{campaign_change.name}\" has been removed form the listing."
        NotificationMailer.campaign_approved_email(nil, campaign_change).deliver_now unless test_env
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
        NotificationMailer.campaign_approved_email(campaign, campaign_change).deliver_now unless test_env
        if !campaign_change.destroy
          flash[:error] = "The corresponding campaign request failed to delete. Please manually delete the 'campaign_change', #{campaign_change.name}"
        end
      else
        flash[:error] = "Oops! We failed to approve this campaign. " + campaign.errors.full_messages.join(". ")
      end
    end
    redirect_to admin_path and return
  end

  def create_status
    status = StatusUpdate.new
    status.campaign_id = params[:status_update]["campaign_id"]
    status.date = params[:status_update]["date"]
    status.text = params[:status_update]["text"]

    if status.save
      flash[:notice] = "Status posted!"
    else
      flash[:error] = "Oops! Something went wrong. Status update not posted."
    end
    redirect_to admin_path and return
  end

  def create_konosioni_payment
    payment = Payment.new
    payment.campaign_id = params[:payment]["campaign_id"]
    payment.time = params[:payment]["time"]
    payment.amount = params[:payment]["amount"]
    payment.transaction_id = params[:payment]["transaction_id"]
    payment.is_anonymous = false
    payment.is_konosioni = true

    if payment.save
      flash[:notice] = "Konosioni payment successfully saved!"
    else
      flash[:error] = "Oops! Something went wrong. This Konosioni payment was not added. "
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
