class Card < ActiveRecord::Base

  belongs_to :game

  def self.get_four_random_cards(deck_cards)
    selected_cards = deck_cards.shuffle[0..3]
    selected_cards_for_view = selected_cards.dup

    selected_cards.each do |card|
      card.delete
    end

    selected_cards_for_view
  end
end
