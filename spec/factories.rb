FactoryBot.define do
  factory :status_update do
    text "MyText"
  end
  
  factory :user do
    email "helpme@sos.com"
    password "password"
    password_confirmation "password"
  end

  factory :organization do
  	user_id 1
    name "Drown the fish"
    is_approved true
  end

  # factory :payment do
  # 	cart Hash(1 => 25, 2 => 10)
  # 	name "John Doe"
  # 	email "test@test.com"
  # 	phone "123-456-7890"
  # 	is_anonymous true
  # 	is_konosioni false
  # end

  factory :campaign do
    organization_id 1
  end
  
end
