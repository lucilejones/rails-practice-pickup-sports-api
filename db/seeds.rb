# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
(1..10).each do |i|
    user = User.create(
        username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
        email: Faker::Internet.email,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        password: 'password',
        password_confirmation: 'password'
    )

    rand(1..10).times do
        user.posts.create(content: Faker::Lorem.paragraph)
    end

    rand(1..10).times do
        user.created_events.create(
            title: Faker::Lorem.sentence,
            end_date_time: Faker::Time.forward(days: 25, period: :morning),
            start_date_time: Faker::Time.forward(days: 25, period: :morning),
            guests: rand(1..10),
            content: Faker::Lorem.paragraph
        )
    end
end