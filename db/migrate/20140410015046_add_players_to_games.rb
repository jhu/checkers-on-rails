class AddPlayersToGames < ActiveRecord::Migration
  def change
    add_column :games, :white_id, :integer
    add_column :games, :red_id, :integer
  end
end
