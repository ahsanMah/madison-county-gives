class CampaignChangesController < ApplicationController
  before_action :authenticate_user!
  before_action :belongs_to_user, :only => [:edit, :update, :destroy]
  before_action :organization_approved, :only => [:new, :create, :edit, :update, :destroy]

  def show
    @campaign_change = CampaignChange.find(params[:id])
    @campaign = Campaign.find(@campaign_change.campaign_id) unless @campaign_change.action == "CREATE"
    @belongs_to_current_user = (user_signed_in?) && (!current_user.organization.nil?) && (@campaign_change.organization.id == current_user.organization.id)
  end

  def new
    campaign_change = CampaignChange.new

    #Retrieve any existing models
    if params[:campaign_id]
      existing_campaign = Campaign.find(params[:campaign_id])
      existing_change = existing_campaign.campaign_change
      campaign_change.campaign_id = params[:campaign_id]
    end

    campaign_change.action = params[:campaign_action] || "CREATE"
    campaign_change.organization_id = current_user.organization.id

    #Populate change with existing campaign fields
    if existing_campaign
      existing_campaign.attributes.each do |key, val|
        if key.to_s != "id" && campaign_change.has_attribute?(key)
          campaign_change[key] = val
        end
      end
    end

    #Bypass new form page if action is to delete campaign
    if campaign_change.action == "DELETE"

      #Override an existing campaign change if it exists
      if existing_campaign && (existing_change = existing_campaign.campaign_change)
        if !existing_change.destroy
          flash[:error] = "There was an existing pending change that we could not override. Please try manually deleting the pending change first."
          redirect_to organization_path(campaign_change.organization_id) and return
        end
      end

      if campaign_change.save
        flash[:notice] = "We have requested the admin to remove \"#{existing_campaign.name}\" from Madison County Gives."
      else
        flash[:error] = "We were unable to request the admin to delete the campaign \"#{existing_campaign.name}\". " + campaign_change.errors.full_messages.join(". ")
      end
        redirect_to organization_path(campaign_change.organization_id) and return
    end

    if existing_change
      redirect_to edit_campaign_change_path existing_change
    end

    @campaign = campaign_change
  end

  def create
    campaign = CampaignChange.new(create_update_params)

    # The image field doesn't auto-populate
    if campaign.campaign_id && !(campaign.image.exists?)
      campaign.image = Campaign.find(campaign.campaign_id).image
    end

    preamble = "Campaign #{campaign.action == "CREATE" ? "proposal" : "update"} for \"#{campaign.name}\""

    if campaign.save
      flash[:notice] = preamble + " successfully submitted for approval!"
      redirect_to organization_path current_user.organization and return
    else
      flash[:error] = "We were unable to submit your " + preamble + ". " + campaign.errors.full_messages.join(". ")
      redirect_to new_campaign_change_path and return
    end
  end

  def edit
    @campaign = CampaignChange.find(params[:id])
  end

  def update
    campaign = CampaignChange.find(params[:id])
    campaign.update(create_update_params)
    campaign[:action] = "UPDATE"

    if campaign.save
      flash[:notice] = "Updates for \"#{campaign.name}\" successfully submitted for approval!"
			redirect_to organization_path current_user.organization and return
    else
      #Unable to save
      flash[:error] = "We were unable to submit \"#{campaign.name}\" for approval. " + campaign.errors.full_messages.join(". ")
      redirect_to edit_campaign_change_path campaign
    end
  end

  def destroy
    campaign_change = CampaignChange.find(params[:id])
    campaign_name = campaign_change.name
    if campaign_change.destroy
        flash[:notice] = "Campaign change for \"#{campaign_name}\" has been removed from the listing."
    else
        flash[:error] = "We were unable to delete \"#{campaign_name}\. " + campaign_change.errors.full_messages.join(". ")
    end
    redirect_to organization_path(current_user.organization.id) and return
  end

  private
  	 def create_update_params
  	   params.require(:campaign_change)
             .permit(:name, :description, :start_date, :goal, :image, :organization_id, :campaign_id, :action)
  	 end

     def belongs_to_user
       unless CampaignChange.find(params[:id]).organization.user.id == current_user.id
         raise ActionController::RoutingError.new('Not Found')
       end
     end

     def organization_approved
       unless current_user.organization.is_approved? || current_user.is_admin
         raise ActionController::RoutingError.new('Not Found')
       end
     end
end
