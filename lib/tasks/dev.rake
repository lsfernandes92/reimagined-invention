namespace :dev do
  desc "Setup the development environment"
  task setup: :environment do
    puts "%%% Creating contact kinds..."

    kinds = %w[friend family work other]

    kinds.each do |kind|
      Kind.create!(description: kind)
    end

    puts "%%% Contact kinds created successfully!"

    puts "%%% Creating 10 new contacts..."

    10.times do |i|
      contact_params = {
        name: Faker::Name.name,
        email: Faker::Internet.email,
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        kind: Kind.all.sample
      }

      Contact.create!(contact_params)
    end

    puts "%%% Contacts created successfully!"
  end

end
