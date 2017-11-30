class CampaignsController < ApplicationController

	def index
		@campaigns = Campaign.all
		@campaigns.each do |camp|
			camp.amount_raised = camp.payments.sum(:amount)
			camp.percent_raised = camp.amount_raised * 1.0 / camp.goal * 100
		end
	end

	def show
		@campaign = Campaign.find(params[:id])
		@campaign.amount_raised = @campaign.payments.sum(:amount)
		@campaign.num_backers = @campaign.payments.count
		@campaign.percent_raised = @campaign.amount_raised * 1.0 / @campaign.goal * 100
		@belongs_to_current_user = (current_user.id == @campaign.organization.user.id)
	end

	# private
	#   def create_update_params
	#     params.require(:campaign).permit(:name, :description, :start_date, :goal, :image)
	#   end

end
