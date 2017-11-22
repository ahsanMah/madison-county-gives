require 'rails_helper'

RSpec.describe HomeController, type: :controller do # we could probably dry this out
	# before :each do
	# 	@c1 = Campaign.new(:id => 1)
	# 	@c2 = Campaign.new(:id => 2)
	# end
	describe "should create payment object from TouchNet data" do
		it "creates payment" do
			u = FactoryBot.create(:user, :id => 1) # god damn associations...
			o = FactoryBot.create(:organization, :id => 1, :user_id => 1)
			c1 = FactoryBot.create(:campaign, :id => 1, :organization_id => 1)
			c2 = FactoryBot.create(:campaign, :id => 2, :organization_id => 1)
			expect{
			post :create_payment, :params => {:pmt_status => "success", :pay_split => {1 => 25.00, 2 => 10.00}, :name => "John Doe", :email => "test@test.com", :phone => "123-456-7890", :transaction_id => 123456, :time => DateTime.now, :is_anonymous => false, :is_konosioni => false}
			}.to change(Payment, :count).by(2)

			# expect(flash[:notice]).to eq "Alert-Thank you for your generous contribution!"
			# payment_params = FactoryBot.attributes_for(:payment)
			# expect {post :create_payment, payment_params}.to change(Payment, :count).by(1)
		end
	end

	describe "GET #summary" do
		it "renders the summary template" do
			c1 = Campaign.new(:id => 1)
				allow(Campaign).to receive(:find).with(1) { c1 }
			c2 = Campaign.new(:id => 2)
				allow(Campaign).to receive(:find).with(2) { c2 }
			get :summary, :session => {:cart => [[1,1], [2,1]]}
			expect(response).to render_template(:summary)
		end
	end

	describe "GET #checkout" do
		it "renders the checkout template" do
			c1 = Campaign.new(:id => 1)
				allow(Campaign).to receive(:find).with(1) { c1 }
			c2 = Campaign.new(:id => 2)
				allow(Campaign).to receive(:find).with(2) { c2 }
			get :checkout, :session => {:cart => [[1,1], [2,1]]}
			expect(response).to render_template(:checkout)
		end
	end

end
