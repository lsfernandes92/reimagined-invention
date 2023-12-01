namespace :dev do
  desc "Setup the development environment"
  task setup: :environment do
    puts "%%% Creating 10 new contacts..."

    10.times do |i|
      contact_params = {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65)
      }

      Contact.create!(contact_params)
    end

    puts "%%% Contacts created successfully!"
  end

end
