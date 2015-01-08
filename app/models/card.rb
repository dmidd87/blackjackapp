class Card < ActiveRecord::Base

  belongs_to :game

  def self.get_value_of_cards(array_of_cards)
    # loop through each card
    # grab the value of the card
    # add values together
    # return the sum
  end


  def self.get_four_random_cards(deck_cards, user_id)
    selected_cards = deck_cards.shuffle[0..3]
    player_cards = selected_cards[0..1]
    dealer_cards = selected_cards[2..3]

    selected_cards.each do |card|
      card.delete
    end

    [player_cards, dealer_cards]
  end
end
