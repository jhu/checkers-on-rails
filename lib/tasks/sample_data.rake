namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_games
    make_ongoing_games
    make_waiting_games
    make_moves
  end
end

def make_users
  25.times do |n|
    name = Faker::Internet.user_name(nil, %w()) + "#{rand(1..30)}"
    password  = "Password1"
    User.create!(name: name,
                 password: password,
                 password_confirmation: password)
  end
  User.create!(name: "johnson",
                 password: "Password1",
                 password_confirmation: "Password1",
                 admin: true)
end

def make_games
  users = User.all(limit: 5)
  users.each do |user|
    5.times do |i|
      game = Game.create!(black:user, winner:user)
      game.update(red:User.first(offset: i+5), result:'1-0')
    end
  end
end

def make_ongoing_games
  users = User.all(limit: 20)
  users.each do |user|
    2.times do |i|
      game = Game.create!(black:user)
      game.update!(red:User.first(offset: i+5), active:true)
    end
  end
end

def make_waiting_games
  5.times { |i| Game.create!(black:User.first(offset:i)) }
end

def make_moves
  games = Game.where("red_id is not null").where(active:false)
  games.each { |game|
    25.times do
      #(B|W):W[1-3]?[0-9](,)
      game.moves.create!(movetext:Faker::Base.regexify(/^[1-3]?[0-9](x[1-3]?[0-9]){1,3}$/),
                          fen:Faker::Base.regexify(/^(B|W):WK?[1-3]?[0-9](,K?[1-3]?[0-9]){3,9}:BK?[1-3]?[0-9](,K?[1-3]?[0-9]){3,9}$/),
                          startpos:Faker::Number.number(2),
                          endpos:Faker::Number.number(2))
    end
  }
end