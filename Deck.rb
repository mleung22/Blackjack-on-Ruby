$LOAD_PATH << '.'
require 'Rank'
require 'Suit'
require 'Card'

class Deck
include Rank, Suit
	
	@@my_deck = Array.new
	@@top_card = -1
	DECK_LIMIT = 52

	def initialize()
		Suit.constants.each do |suit|
			Rank.constants.each do |rank|
				@@my_deck << Card.new(rank, suit)
			end
		end
	end

	# Deals one card
	def deal()
		@@my_deck[@@top_card += 1] if @@top_card < DECK_LIMIT	
	end

	# Shuffles and resets entire deck
	def shuffle()
		
		for x in 0...DECK_LIMIT
			random_index = rand(DECK_LIMIT)

			tmp = @@my_deck[x]
			@@my_deck[x] = @@my_deck[random_index]
			@@my_deck[random_index] = tmp
		end

		@@top_card = -1
	end
end
