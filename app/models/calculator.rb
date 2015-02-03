class Calculator

  def self.calculate(params, session)
    runner = new(params, session)
    runner.run
  end

  attr_reader :params, :session
  attr_accessor :game, :dealer_cards, :dealer_cards_value, :player_cards, :player_cards_value, :cards

  def initialize(params, session)
    @params = params
    @session = session
  end

  def run
    if params[:commit] == "Deal Cards"
      setup_new_game
    end

    self.game = Game.find(params[:id])
    self.cards = Card.where(game_id: game.id)

    self.dealer_cards = cards.select{|card| card.player == 'dealer'}
    self.dealer_cards_value = Card.get_value_of_cards(dealer_cards)
    self.player_cards = cards.select{|card| card.player == 'you' }
    self.player_cards_value = Card.get_value_of_cards(player_cards)

    self.hit
    self.stand
    self.doubledown

    {
      game: game,
      dealer_cards_value: dealer_cards_value,
      player_cards_value: player_cards_value,
      cards: cards,
    }
  end

  # private below here....

  def has_blackjack
    if self.player_cards_value == 21
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      if self.dealer_cards_value == 21
        self.game.winner = 'push'
        self.game.save
      end
      if self.dealer_cards_value < 21
        Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
        self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
        self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      end
      if self.dealer_cards_value < 21
        Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
        self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
        self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      end
      if self.dealer_cards_value < 21
        Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
        self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
        self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      end
      if self.dealer_cards_value < 21
        Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
        self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
        self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      end
    end

    if self.dealer_cards_value == 21 && self.player_cards_value < 21
      self.game.winner = 'dealer'
      self.game.save
    end
    if self.dealer_cards_value == 21 && self.player_cards_value == 21
      self.game.winner = 'push'
      self.game.save
    end
  end

  def player_rules
    if self.player_cards_value > 21
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      self.game.winner = 'dealer'
      self.game.save
    end
  end

  def dealer_rules
    if self.dealer_cards_value < 17 && self.player_cards_value > self.dealer_cards_value && self.player_cards_value <= 20
      Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
    end
    if self.dealer_cards_value < 17 && self.player_cards_value > self.dealer_cards_value && self.player_cards_value <= 20
      Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
    end
    if self.dealer_cards_value < 17 && self.player_cards_value > self.dealer_cards_value && self.player_cards_value <= 20
      Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
    end
    if self.dealer_cards_value < 17 && self.player_cards_value > self.dealer_cards_value && self.player_cards_value <= 20
      Card.run_dealers_hand(self.game, self.cards, self.dealer_cards_value, self.player_cards_value)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
    end
    if self.dealer_cards_value >= 17 && self.dealer_cards_value > self.player_cards_value && self.dealer_cards_value < 20
      self.game.winner = 'dealer'
      self.game.save
    end
    if dealer_cards_value > 21 && player_cards_value <= 21
      game.winner = 'you'
      game.save
    end
    if self.dealer_cards_value >= 17 && self.player_cards_value > self.dealer_cards_value
      self.game.winner = 'you'
      self.game.save
    end
    if self.dealer_cards_value >= 17 && self.player_cards_value < self.dealer_cards_value
      self.game.winner = 'dealer'
      self.game.save
    end
    if dealer_cards_value == player_cards_value && dealer_cards_value < 21 && player_cards_value < 21
      game.winner = 'push'
      game.save
    end
  end

  def hit
    if params[:commit] == "Hit"
      Card.give_player_a_card(self.cards)
      self.cards = Card.where(game_id: self.game.id)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.has_blackjack
      self.player_rules
    end
  end

  def stand
    if params[:commit] == "Stand"
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.has_blackjack
      self.dealer_rules
    end
  end

  def doubledown
    if params[:commit] == "Double Down"
      Card.give_player_a_card(cards)
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.has_blackjack
      self.player_rules
      self.dealer_rules
    end
  end

  def setup_new_game
    GameGenerator.generate_cards(params[:id])
    self.game = Game.find(params[:id])
    self.cards = game.cards
    Card.get_four_random_cards(cards, session[:user_id])
  end
end
