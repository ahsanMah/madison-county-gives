require 'rails_helper'

RSpec.describe CampaignChangesController, type: :controller do

	describe "should handle failures correctly" do
		login_user #method defined in support/controller_macros.rb
		setup_campaign_change_failure_stubs

		it "should redirect to organization page if failed to delete exisitng change" do
			campaign = Campaign.new(:name=>"Please work")
			expect(Campaign).to receive(:find).with("1") { campaign }

			get :new, :params => {:campaign_id => 1, :campaign_action => "DELETE"}
			expect(response).to redirect_to organization_path subject.current_user.organization.id
		end
	
		it "should redirect to new form page when failed to create" do
			post :create, :params => {:campaign_change => {:action => "CREATE"}}
			expect(response).to redirect_to new_campaign_change_path
		end

		it "should redirect to new form page when failed to save update" do
			post :update, :params => {:id => 1, :campaign_change => {:action => "UPDATE"}}
			expect(response).to redirect_to edit_campaign_change_path({:id => 1})
		end

	end
end
