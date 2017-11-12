class CampaignsController < ApplicationController

	def index
		@campaigns = Campaign.all
	end

	def show
		@campaign = Campaign.find(params[:id])
	end

	private
	  def create_update_params
	    params.require(:campaign).permit(:name, :description, :start_date, :goal, :image)
	  end

end
