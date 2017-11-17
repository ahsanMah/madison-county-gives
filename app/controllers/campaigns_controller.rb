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
	end

	# private
	#   def create_update_params
	#     params.require(:campaign).permit(:name, :description, :start_date, :goal, :image)
	#   end

end
