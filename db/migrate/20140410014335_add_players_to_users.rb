class AddPlayersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :black_id, :integer
    add_column :users, :red_id, :integer
  end
end
