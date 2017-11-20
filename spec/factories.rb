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

end