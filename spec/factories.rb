FactoryGirl.define do
	factory :business do
     name 			 Faker::Company.name
     thumbnail 	 Faker::Company.logo
     email 			 Faker::Internet.email
     phone 			 Faker::PhoneNumber.cell_phone
     address 		 Faker::Address.street_address
     longitude 	 Faker::Address.latitude
     latitude 	 Faker::Address.longitude
     description Faker::Company.catch_phrase
	end

	factory :api_key do
		business_id  FactoryGirl.create(:business).id
	end
end
