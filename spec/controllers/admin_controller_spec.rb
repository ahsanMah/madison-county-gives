require 'rails_helper'

RSpec.describe AdminController, type: :controller do
	login_admin

	describe "should handle failures correctly" do
		setup_admin_failure_stubs
		
		it "should redirect to admin path if organization approval fails" do
			get :organization_approval, :params => {:organization_id => 1}
			expect(response).to redirect_to admin_path
		end

		it "should flash failure message if campaign change deletion fails after campaign deletion" do
			change = CampaignChange.new
			allow(change).to receive(:action) {"DELETE"}
			allow(change).to receive(:organization) {create(:organization)}
			allow(Campaign).to receive(:destroy).with(1){ true }

			get :campaign_approval, :params => {:campaign_change_id => 1, :test_env => true}
			expect(flash[:error]).to match /.*The corresponding delete request.*/
			expect(response).to redirect_to admin_path
		end

		it "should flash failure message if campaign deletion fails" do
			change = CampaignChange.new
			allow(change).to receive(:action) {"DELETE"}

			expect(Campaign).to receive(:find) {Campaign.new}
			expect(Campaign).to receive(:destroy).with(1){ nil }

			get :campaign_approval, :params => {:campaign_change_id => 1, :test_env => true}
			expect(flash[:error]).to match /.*We were unable to delete.*/
			expect(response).to redirect_to admin_path
		end

		it "should flash failure message if campaign save fails" do
			change = CampaignChange.new
			allow(change).to receive(:action) {"UPDATE"}

			campaign = Campaign.new
			expect(Campaign).to receive(:find) {campaign}
			expect(campaign).to receive(:save) { nil }

			get :campaign_approval, :params => {:campaign_change_id => 1, :activate => true}
			expect(flash[:error]).to match /.*We failed to approve.*/
			expect(response).to redirect_to admin_path
		end

	end
end