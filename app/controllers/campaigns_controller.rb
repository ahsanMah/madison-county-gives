class CampaignsController < ApplicationController

	def new

		# #Only allow to create a campaign if approved 
		# organization = Organization.find(params[:id])
		# if !organization.is_approved
		# 	flash[:error] = "Organization has to get approved for campaign creation"
		# 	redirect_to organization_index_path(organization)
		# end

		@campaign = Campaign.new
	end

	def create
		campaign = Campaign.new(create_update_params)
		logger.debug("New campaign => #{campaign}")
		if campaign.save
			flash[:notice] = "Campaign successfully submitted for approval!"
			redirect_to root_path and return
		aelse
			flash[:error] = "Unable to submit!"
			redirect_to root_path
		end
	end

	private
	  def create_update_params
	    params.require(:campaign).permit(:name, :description, :start_date, :goal, :image)
	  end



end
