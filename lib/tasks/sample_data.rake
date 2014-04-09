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
    #users = User.all(limit: 6)
    #users = User.all
    #user = users.first
    #blackplayers = users[1..50]
    #redplayers = users[51..100]
    #50.times do |n|
    #  game = Game.create!()
    #  game.black = blackplayers[n]
    #  game.red = redplayers[n]
    #end
  end
end