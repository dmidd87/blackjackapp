class Card < ActiveRecord::Base

  belongs_to :game

  def self.get_value_of_cards(cards)
    cards.select(&:face_up?).map(&:points).inject(:+)
  end

  def self.get_four_random_cards(cards_in_deck, user_id)
    raise 'You have to have at least 4 cards in the deck' unless cards_in_deck.length >= 4
    selected_cards = cards_in_deck.shuffle[0..3]
    player_cards = selected_cards[0..1]
    dealer_cards = selected_cards[2..3]

    player_cards.each do |card|
      card.update(player: 'you')
    end

    dealer_cards.each do |card|
      card.update(player: 'dealer')
    end

    dealer_cards.first.update(face_up: false)

    [player_cards, dealer_cards]
  end

  def self.give_player_a_card(cards_in_deck)
    new_card = cards_in_deck.shuffle[0]
    new_card.update(player: 'you')
  end

  def self.run_dealers_hand(game, cards_in_deck, dealer_cards_value, player_cards_value)
    new_card = cards_in_deck.shuffle[0]
    new_card.update(player: 'dealer')
  end
end
