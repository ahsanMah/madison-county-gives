module ControllerMacros
  
  ##### Will be ueful in the near future ######
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
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
        change = CampaignChange.new(:id => 1, :name => "Why hello there")
        
        allow(CampaignChange).to receive(:new) { change }
        allow(CampaignChange).to receive(:find).with("1") { change }
        allow(change).to receive(:destroy) {nil}
        allow(change).to receive(:save) {nil}
      end
  end

end