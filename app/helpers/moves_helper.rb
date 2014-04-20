module MovesHelper
	#"11x18x25"
	def get_start_postion(movetext)
		movetext.split('x').map(&:to_i)[0]
	end
	
	def get_end_position(movetext)
		movetext.split('x').map(&:to_i)[-1]
	end

	#"B:W18,24,27,28,K10,K15:B12,16,20,K22,K25,K29"
	def whose_turn(fen)
		fen[0,1]
	end
end