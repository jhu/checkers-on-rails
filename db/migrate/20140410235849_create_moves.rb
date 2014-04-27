class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :game, index: true
      t.string :movetext
      t.string :board
      t.string :turn

      t.timestamps
    end
  end
end
