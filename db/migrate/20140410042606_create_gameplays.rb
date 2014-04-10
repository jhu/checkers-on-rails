class CreateGameplays < ActiveRecord::Migration
  def change
    create_table :gameplays do |t|
      t.references :game, index: true
      t.string :move
      t.string :state

      t.timestamps
    end
  end
end
