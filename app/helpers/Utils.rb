module Utils
	# Takes an index in standard notation and returns the
	# row it belongs to.
	def index_to_row(piece_index)
		row_index = (piece_index - 1) / 4
	end
end
