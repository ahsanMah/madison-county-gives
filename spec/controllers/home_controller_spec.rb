require 'rails_helper'

RSpec.describe HomeController, type: :controller do
	describe "should create payment object from processing form" do
		it "creates payment" do
			payment_params = FactoryGirl.attributes_for(:payment)
			expect {post :create_payment, :payment => payment_params}.to change(Payment, :count).by(1)
		end
	end


end