require 'rails_helper'

RSpec.describe AdminController, type: :controller do
	login_admin

	describe "should handle failures correctly" do
		setup_admin_failure_stubs
		
		it "should redirect to admin path if organization approval fails" do
			get :organization_approval, :params => {:organization_id => 1}
			expect(response).to redirect_to admin_path
		end
	
	end
end