class AddBoardToGames < ActiveRecord::Migration
  def change
    add_column :games, :turn, :string, default: "black"
    add_column :games, :board, :string, default: "0,-1,0,-1,0,-1,0,-1,-1,0,-1,0,-1,0,-1,0,0,-1,0,-1,0,-1,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1,1,0,1,0,1,0,1,0"
  end
end
