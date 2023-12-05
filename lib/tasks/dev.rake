namespace :dev do
  desc "Setup the development environment"
  task setup: :environment do
    puts "%%% Setting up the environment..."
    %x(rails db:drop db:create db:migrate)
    puts "%%% Environment set up successfully!"

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

    puts "%%% Creating and assigning the contact phones numbers..."
    Contact.all.each do |contact|
      Random.rand(1..5).times do |i|
        phone = Phone.new(number: Faker::PhoneNumber.phone_number)
        contact.phones << phone
        contact.save!
      end
    end
    puts "%%% Contact phone numbers created successfully!"
  end

end
