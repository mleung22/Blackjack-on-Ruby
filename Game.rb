$LOAD_PATH << '.'
require 'Rank'
require 'Suit'
require 'Card'
require 'Deck'

# Checks if player or dealer busted
def check_bust(name, sum)
	if sum > 21
		return true
	else
		return false
	end
end

def dealer_hit_limit(sum)
	if sum < 17
		return true
	else
		return false
	end
end

# Game setup
deck = Deck.new
player = Array.new
dealer = Array.new
player_sum = 0
dealer_sum = 0
deck.shuffle

# Game begins
puts "----------------"
puts "Player Hand"
puts "----------------"

# Deals and sums 2 cards to the current player
2.times { player << deck.deal } 
player.each do |card| 
	puts card
	player_sum = player_sum + Rank.const_get(card.rank)
end

puts "\n----------------"
puts "Dealer Hand"
puts "----------------"

# Deals and sums 2 cards for the dealer
2.times { dealer << deck.deal }
dealer.each do |card| 
	puts card
	dealer_sum = dealer_sum + Rank.const_get(card.rank)
end

# Prints sum
puts "\nYour current total is #{player_sum} \nDealer current total is #{dealer_sum}"

# Asks if player wants to hit
player_deciding = true
player_card_draw = 2 # Index of card drawn

while player_deciding do

	puts "\nWould you like to hit? (Y or N)"
	answer = gets.chomp.upcase!

	if answer == "Y"
		player << deck.deal 
		puts "\nYou drew: #{player[player_card_draw]}"

		player_sum = player_sum + Rank.const_get(player[player_card_draw].rank)
		puts "Your current hand total is: #{player_sum}"

		player_card_draw += 1

		if check_bust("Player", player_sum)# Checks if player busted
			player_deciding = false 
			puts "Player busted! \nDealer Wins!"
		end
	else
		player_deciding = false
	end
end

# Dealer's turn
dealer_deciding = true
dealer_card_draw = 2 # Index of card drawn

while dealer_deciding

	break if check_bust("Player", player_sum)

	if dealer_hit_limit(dealer_sum)
		dealer << deck.deal
		puts "\nDealer drew: #{dealer[dealer_card_draw]}"

		dealer_sum = dealer_sum + Rank.const_get(dealer[dealer_card_draw].rank)
		puts "Dealer current hand total is: #{dealer_sum}"

		dealer_card_draw += 1

		if check_bust("Dealer", dealer_sum)
			dealer_deciding = false
			puts "Dealer busted! \nPlayer wins!"
		end
	else
		dealer_deciding = false
	end

end

if player_sum > dealer_sum && !check_bust("Player", player_sum) && !check_bust("Dealer", dealer_sum)
	puts "Player wins!"
elsif player_sum < dealer_sum && !check_bust("Player", player_sum) && !check_bust("Dealer", dealer_sum)
	puts "Dealer Wins!"
end
