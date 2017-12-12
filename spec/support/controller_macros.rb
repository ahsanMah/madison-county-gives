module ControllerMacros
  
  ##### Will be ueful in the near future ######
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      # user.is_admin = true
      sign_in user
    end
  end

  #User should have id 1 and organization 1 
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = create(:user)
      user.organization = create(:organization)
      sign_in user
    end
  end

  def setup_campaign_change_failure_stubs

    before(:each) do
        change = CampaignChange.new({:organization_id => 1,:id => 1, :name => "Why hello there"})
        
        allow(CampaignChange).to receive(:new) { change }
        allow(CampaignChange).to receive(:find).with("1") { change }
        allow(change).to receive(:destroy) {nil}
        allow(change).to receive(:save) {nil}
      end
  end

  def setup_admin_failure_stubs

    before(:each) do
        change = CampaignChange.new({:organization_id => 1,:id => 1, :name => "Why hello there"})
        
        allow(CampaignChange).to receive(:new) { change }
        allow(CampaignChange).to receive(:find).with("1") { change }
        allow(change).to receive(:destroy) {nil}
        allow(change).to receive(:save) {nil}
      
        organization = Organization.new({:id => 1, :name => "Bathe the whales"})
        allow(Organization).to receive(:find).with("1") { organization }
        allow(organization).to receive(:save) {nil}
      end
  end

end