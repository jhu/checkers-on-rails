class AddResultActiveToGames < ActiveRecord::Migration
  def change
    add_column :games, :active, :boolean, default: false
  end
end