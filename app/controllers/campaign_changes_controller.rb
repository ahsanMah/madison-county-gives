class CampaignChangesController < ApplicationController

  def show
    @campaigns = CampaignChange.find(params[:id])
  end

  def new
    @campaign = CampaignChange.new
    if !params[:campaign_id].nil?
      Campaign.find(params[:campaign_id]).attributes.each do |curKey, curVal|
        if @campaign.has_attribute? curKey
          @campaign[curKey] = curVal
        end
      end
    end
  end

  def create
    campaign = CampaignChange.new(create_update_params)
    campaign.action = "CREATE"
    if !campaign.id.nil?
      campaign.action = "UPDATE"
    end
		
		if campaign.action == "CREATE"
				campaign.organization_id = current_user.organization_id
		end

    if campaign.save
			flash[:notice] = "Campaign proposal for \"#{campaign.name}\" successfully submitted for approval!"
			redirect_to campaigns_path and return
		else
			flash[:error] = "Unable to submit!"
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
    else
      flash[:error] = "Unable to submit!"
      redirect_to edit_campaign_change_path
    end
  end

  private
  	 def create_update_params
  	   params.require(:campaign_change).permit(:name, :description, :start_date, :goal, :image)
  	 end
end
