class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.references :game, index: true
      t.string :movetext
      t.string :fen
      t.string :startpos
      t.string :endpos

      t.timestamps
    end
  end
end
