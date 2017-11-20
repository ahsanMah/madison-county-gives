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
end