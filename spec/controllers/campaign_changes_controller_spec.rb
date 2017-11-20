require 'rails_helper'

RSpec.describe CampaignChangesController, type: :controller do

	describe "should handle failures correctly" do
		login_user #method defined in support/controller_macros.rb

		it "should redirect to organization page if failed to delete exisitng change" do
			campaign = Campaign.new(:name=>"Please work")
			change = CampaignChange.new

			expect(subject.current_user).to_not eq(nil)
			expect(Campaign).to receive(:find).with("1") { campaign }
			expect(CampaignChange).to receive(:new) { change }
			expect(change).to receive(:save) {nil}

			get :new, :params => {:campaign_id=>1, :campaign_action => "DELETE"}
			expect(response).to redirect_to organization_path subject.current_user.organization.id
		end
	
		# it "should redirect to new form page when failed to create" do
		# 	campaign = Campaign.new(:name=>"Please work")
		# 	change = CampaignChange.new
		# 	@request.env["devise.mapping"] = Devise.mappings[:user]
	 #  		user = create(:user)
		# 	user.organization = create(:organization)
	 #  		sign_in user

		# 	expect(subject.current_user).to_not eq(nil)

		# 	expect(Campaign).to receive(:find).with("1") { campaign }
		# 	expect(CampaignChange).to receive(:new) { change }
		# 	expect(change).to receive(:save) {nil}

		# 	get :new, :params => {:campaign_id=>1, :campaign_action => "DELETE"}
		# 	expect(response).to redirect_to(organization_path(user.organization.id))
		# end
	end
end
