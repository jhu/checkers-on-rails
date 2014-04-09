namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "admin",
                 password: "Admin1",
                 password_confirmation: "Admin1",
                 admin: true)
    99.times do |n|
      #name  = "username#{n+1}"
      name = Faker::Internet.user_name + "#{rand(5..30)}"
      password  = "Password1"
      User.create!(name: name,
                   password: password,
                   password_confirmation: password)
    end
    users = User.all(limit: 6)
    20.times do
      #content = Faker::Lorem.sentence(5)
      users.each { |user| user.games.create!() }
    end
  end
end