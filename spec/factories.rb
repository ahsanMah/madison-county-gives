FactoryBot.define do

  factory :user do
    email "helpme@sos.com"
    password "password"
    password_confirmation "password"
  end

  factory :organization do
  	user_id 1
    name "Drown the fish"
  end

  factory :payment_params do
  	cart Hash(1 => 25, 2 => 10)
  	name "John Doe"
  	email "test@test.com"
  	phone "123-456-7890"
  	is_anonymous true
  	is_konosioni false
  end

end
