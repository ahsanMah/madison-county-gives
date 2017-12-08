require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
	describe "payment helpers" do
		it "encodes correctly" do
			encode_me = {1 => 10.00, 2 => 0.50, 3 => 300.00}
			expect(encode(encode_me)).to eq("1:10.0;2:0.5;3:300.0")
		end

		it "decodes correctly" do
			decode_me = "1:10.00;2:0.50;3:300.00"
			expect(decode(decode_me)).to eq({1 => 10.00, 2 => 0.50, 3 => 300.00})
		end
	end
end