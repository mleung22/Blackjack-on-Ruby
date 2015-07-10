$LOAD_PATH << '.'
require 'Rank'
require 'Suit'

class Card
include Rank, Suit
	attr_accessor :rank
	attr_accessor :suit

	def initialize(rank, suit)
		@rank = rank
		@suit = suit
	end

	def to_s
		"#{@rank} of #{@suit}" 
	end
end

