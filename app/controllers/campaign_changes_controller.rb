class CampaignChangesController < ApplicationController

  def show
    @campaign = CampaignChange.find(params[:id])
  end

  def new
    campaign_change = CampaignChange.new

    #Populate change with existing campaign fields
    if params[:campaign_id]
      exiting_campaign = Campaign.find(params[:campaign_id])
      existing_campaign.attributes.each do |curKey, curVal|
        if campaign_change.has_attribute? curKey
          campaign_change[curKey] = curVal
        end
      end
      campaign_change.campaign_id = existing_campaign.id
    end

    campaign_change.action = params[:campaign_action] || "CREATE"
    campaign_change.organization_id = current_user.organization.id
    
    @campaign = campaign_change
  end

  def create
    campaign = CampaignChange.new(create_update_params)

    if campaign.save
			flash[:notice] = "Campaign proposal for \"#{campaign.name}\" successfully submitted for approval!"
			redirect_to organization_path current_user.organization and return
		else
			flash[:error] = "Unable to submit campaign proposal!"
			redirect_to new_campaign_change_path
		end
  end

  def edit
    @campaign = CampaignChange.find(params[:id])
  end

  def update
    campaign = CampaignChange.find(params[:id])
    campaign.update(create_update_params)
    campaign.action = "UPDATE"
    if campaign.save
      flash[:notice] = "Updates for \"#{campaign.name}\" successfully submitted for approval!"
      redirect_to campaigns_path and return
    end
    
    #Unable to save
    flash[:error] = "Unable to submit \"#{campaign.name}\" for approval!"
    
    if campaign.action == "CREATE"
      redirect_to new_campaign_change_path @campaign and return
    end

    redirect_to edit_campaign_change_path @campaign
  end

  def approve
    @pending_campaign = CampaignChange.find(params[:id])
    @approved_campaign = Campaign.new()
    
    @pending_campaign.attributes.each do |curKey, curVal|
        if @approved_campaign.has_attribute? curKey
          @approved_campaign[curKey] = curVal
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

  private
  	 def create_update_params
  	   params.require(:campaign_change).permit(:name, :description, :start_date, :goal, :image)
  	 end
end
