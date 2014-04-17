module GamesHelper
  # here should check for legal/illegal move based on previous move?
  # check if this is correct user for this game
  #def ongoing?(game)
  #  game.active
  #end

  def correct_player

  end

  def legal_move?(move)
  	@prevMove = self.moves.order("created_at").last
  	get_turn(@prevMove.fen)
  	  	#self.moves.last # previous move that has been saved into
  end
end