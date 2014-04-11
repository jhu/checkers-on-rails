namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_games
    make_waiting_games
    make_moves
  end
end

def make_users
  25.times do |n|
    name = Faker::Internet.user_name + "#{rand(1..30)}"
    password  = "Password1"
    User.create!(name: name,
                 password: password,
                 password_confirmation: password)
  end
  User.create!(name: "admin",
                 password: "Admin1",
                 password_confirmation: "Admin1",
                 admin: true)
end

def make_games
  users = User.all(limit: 5)
  all_users = User.all
  users.each do |user|
    5.times do |i|
      game = Game.create!(black:user, winner:user)
      game.update(red:User.first(offset: i+5))
    end
  end
end

def make_waiting_games
  5.times { |i| Game.create!(black:User.first(offset:i)) }
end

def make_moves
  games = Game.where("red_id is not null")
  games.each { |game|
    25.times do
      game.moves.create!(movetext:Faker::Lorem.characters(10),
                          fen:Faker::Lorem.characters(20),
                          startpos:Faker::Lorem.word,
                          endpos:Faker::Lorem.word)
    end
  }
end