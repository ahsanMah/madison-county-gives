require 'rails_helper'

RSpec.describe HomeController, type: :controller do
	describe "should create payment object from processing form" do
		it "creates payment" do
			post :create_payment, :params => {:pay_split => {1 => 25.00, 2 => 10.00}, :name => "John Doe", :email => "test@test.com", :phone => "123-456-7890", :transaction_id => 123456, :time => DateTime.now, :is_anonymous => false, :is_konosioni => false}
			expect(flash[:notice]).to eq "Alert-Thank you for your generous contribution!"
			# payment_params = FactoryBot.attributes_for(:payment)
			# expect {post :create_payment, payment_params}.to change(Payment, :count).by(1)
		end
	end
end