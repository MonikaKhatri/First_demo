namespace :db do
	
	desc "Fill db with sample data"
	
	task populate: :environment do
		User.create!(username: "Monika Khatri", email: "monika@complitech.com", location: "G'Nagar" ,password: "123456789", password_confirmation: "123456789")

		99.times do |n|
			username = Faker::Name.name
			email = "test#{n+1}@complitech.com"
			password = "password"
			location = "Ahmedabad"
			User.create!(username: username, email: email, location: location, password: password, password_confirmation: password )
		end
	end
end