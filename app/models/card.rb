class Card < ActiveRecord::Base

  belongs_to :game

  def self.get_value_of_cards(cards)
    cards.select(&:face_up?).map(&:points).inject(:+)
  end

  def self.get_four_random_cards(deck_cards, user_id)
    selected_cards = deck_cards.shuffle[0..3]
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

  def self.give_player_a_card(deck_cards)
    new_card = deck_cards.shuffle[0]
    new_card.update(player: 'you')
  end

  def self.run_dealers_hand(game, deck_cards, dealer_cards_value, player_cards_value)
    p dealer_cards_value
    p player_cards_value
    if dealer_cards_value > player_cards_value
      game.winner = 'dealer'
      game.save
    else
      new_card = deck_cards.shuffle[0]
      new_card.update(player: 'dealer')
    end

  end
end
