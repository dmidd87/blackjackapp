class Foo

  def self.do_shit(params, session)
    if params[:commit] == "Deal Cards"
      GameGenerator.generate_cards(params[:id])
      game = Game.find(params[:id])
      cards = game.cards
      Card.get_four_random_cards(cards, session[:user_id])
    end

    game = Game.find(params[:id])
    cards = Card.where(game_id: game.id)

    if params[:commit] == "Hit"
      Card.give_player_a_card(cards)
      cards = Card.where(game_id: game.id)
      player_cards = cards.select{|card| card.player == 'you'}
      player_cards_value = Card.get_value_of_cards(player_cards)
      dealer_cards = cards.select{|card| card.player == 'dealer'}
      dealer_cards_value = Card.get_value_of_cards(dealer_cards)
      if player_cards_value > 21
        game.winner = 'dealer'
        game.save
      end
    end

    dealer_cards = cards.select{|card| card.player == 'dealer'}
    dealer_cards_value = Card.get_value_of_cards(dealer_cards)
    player_cards = cards.select{|card| card.player == 'you' }
    player_cards_value = Card.get_value_of_cards(player_cards)

    # if player_cards_value > 21 && #Has an ace
    #   #ace value goes from 11 to 1
    # end

    if params[:commit] == "Stand"
      cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      dealer_cards_value = Card.get_value_of_cards(dealer_cards)
      if dealer_cards_value > player_cards_value && player_cards_value < 21
        game.winner = 'dealer'
        game.save
      end
      if player_cards_value > dealer_cards_value && player_cards_value < 21
        Card.run_dealers_hand(game, cards, dealer_cards_value, player_cards_value)
      end
      #It's only checking if the dealer hands is bigger once and giving the dealer once
    end

    if params[:commit] == "Double Down"
      Card.give_player_a_card(cards)
      cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      dealer_cards_value = Card.get_value_of_cards(dealer_cards)
      player_cards_value = Card.get_value_of_cards(player_cards)

      if player_cards_value <= 21 && dealer_cards_value < player_cards_value
        Card.run_dealers_hand(game, cards, dealer_cards_value, player_cards_value)
      end

      if player_cards_value > 21
        game.winner = 'dealer'
        game.save
      end
    end

    if dealer_cards_value > player_cards_value && dealer_cards_value < 21
      game.winner = 'dealer'
      game.save
    end

    if dealer_cards_value == 21 && player_cards_value < 21
      cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      game.winner = 'dealer'
      game.save
    end

    if player_cards_value == 21
      cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      Card.run_dealers_hand(game, cards, dealer_cards_value, player_cards_value)
      if dealer_cards_value == 21 #and the player received 21 after the first two cards
        game.winner = 'push'
      else
        game.winner = 'you'
      end
      game.save
    end

    if player_cards_value > 21
      cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      game.winner = 'dealer'
      game.save
    end

    if dealer_cards_value > 21 && player_cards_value <= 21
      game.winner = 'you'
      game.save
    end

    if dealer_cards_value <= 21 && player_cards_value < 21 && dealer_cards_value > player_cards_value
      game.winner = 'dealer'
      game.save
    end

    if dealer_cards_value == 21 && player_cards_value == 21
      game.winner = 'push'
      game.save
    end

    if dealer_cards_value == player_cards_value && dealer_cards_value < 21 && player_cards_value < 21
      game.winner = 'push'
      game.save
    end

    {
      game: game,
      dealer_cards_value: dealer_cards_value,
      player_cards_value: player_cards_value,
      cards: cards,
    }
  end
end
