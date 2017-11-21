require 'rails_helper'

RSpec.describe CampaignChangesController, type: :controller do
	
	login_user #method defined in support/controller_macros.rb

	describe "should handle failures correctly" do
		setup_campaign_change_failure_stubs

		it "should redirect to organization page if failed to delete existing change" do
			campaign = Campaign.new(:name=>"Please work")
			expect(Campaign).to receive(:find).with("1") { campaign }

			get :new, :params => {:campaign_id => 1, :campaign_action => "DELETE"}
			expect(response).to redirect_to organization_path subject.current_user.organization.id
		end
		
		it "should redirect to organization page if failed to override existing change" do
			campaign = Campaign.new(:name=>"Please work", :campaign_change => CampaignChange.new)
			expect(Campaign).to receive(:find).with("1") { campaign }

			get :new, :params => {:campaign_id => 1, :campaign_action => "DELETE"}
			expect(flash[:error]).to eq "There was an existing pending change that we could not override. Please try manually deleting the pending change first."
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

		it "should redirect to organization page when failed to delete camapign change" do
			delete :destroy, :params => {:id => 1}
	        expect(flash[:error]).to eq "Unable to delete \"#{CampaignChange.find("1").name}\"!"
			expect(response).to redirect_to organization_path subject.current_user.organization.id
		end

	end

	it "should redirect to organization page upon a campaign change deletion" do
		change = CampaignChange.new(:id => 1, :name => "Why hello there")
        allow(CampaignChange).to receive(:find).with("1") { change }

		delete :destroy, :params => {:id => 1}
        expect(flash[:notice]).to eq "Campaign change for \"#{change.name}\" has been removed form the listing"
		expect(response).to redirect_to organization_path subject.current_user.organization.id
	end

	describe "should approve changes correctly" do
	end
end