class CampaignChangesController < ApplicationController
  before_action :authenticate_user!
  before_action :belongs_to_user, :only => [:edit, :update, :destroy]

  def index
    if params[:posting_id] != nil
      puts "successfully posted back"
    end
  end
  
  def show
    @campaign = CampaignChange.find(params[:id])
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
        flash[:error] = "We were unable to delete the campaign \"#{existing_campaign.name}\". " + campaign_change.errors.full_messages.join(". ")
      end
        redirect_to organization_path(campaign_change.organization_id) and return
    end

    if existing_change
      redirect_to edit_campaign_change_path existing_change
    end

    #Populate change with existing campaign fields
    if existing_campaign
      existing_campaign.attributes.each do |key, val|
        if key.to_s != "id" && campaign_change.has_attribute?(key)
          campaign_change[key] = val
        end
      end
    end

    @campaign = campaign_change
  end

  def create
    campaign = CampaignChange.new(create_update_params)
    if campaign.action == "UPDATE" && !(campaign.image.exists?) # the image field doesn't auto-populate
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

    if campaign.save
      flash[:notice] = "Updates for \"#{campaign.name}\" successfully submitted for approval!"
			redirect_to organization_path current_user.organization and return
    end

    #Unable to save
    flash[:error] = "Unable to submit \"#{campaign.name}\" for approval!"

    if campaign.action == "CREATE"
      redirect_to new_campaign_change_path @campaign and return
    end

    redirect_to edit_campaign_change_path @campaign
  end

  def approve
    #TODO: CHECK THAT ADMIN IS LOGGED IN

    @pending_campaign = CampaignChange.find(params[:id])
    campaign_id = @pending_campaign.campaign_id
    @approved_campaign = campaign_id ? Campaign.find(campaign_id) : Campaign.new()


    if @pending_campaign.action == "DELETE"
      if @approved_campaign.destroy(campaign_id)
        flash[:notice] = "Campaign \"#{campaign.name}\ has been removed form the listing."
      else
         flash[:error] = "Unable to delete \"#{campaign.name}\"!"
      end
      redirect_to organization_path(current_user.organization.id) and return
    end

    #Populating campaign with values from changes
    @pending_campaign.attributes.each do |key, val|
        if key.to_s != "id" && @approved_campaign.has_attribute?(key)
          @approved_campaign[key] = val
        end
    end

    if @approved_campaign.save
      flash[:notice] = "Campaign has been successfully approved!"
      @pending_campaign.destroy
      redirect_to campaign_path @approved_campaign and return
    else
      flash[:error] = "Oops! We failed to approve this campaign, please try again."
      redirect_to campaign_change_path @pending_campaign
    end

  end

  def destroy
    campaign_change = CampaignChange.find(params[:id])
    if campaign_change.destroy
        flash[:notice] = "Campaign change for \"#{campaign_change.name}\ has been removed form the listing"
      else
        flash[:error] = "Unable to delete \"#{campaign_change.name}\"!"
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
end
