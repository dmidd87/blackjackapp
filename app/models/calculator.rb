class Calculator

  def self.calculate(params, current_user)
    runner = new(params, current_user)
    runner.run
  end

  attr_reader :params, :current_user
  attr_accessor :game, :dealer_cards, :dealer_cards_value, :player_cards, :player_cards_value, :cards

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def run
    if params[:commit] == "Deal Cards"
      setup_new_game
    end

    if params[:commit] == "New Hand"
      new_hand
    end

    self.game = Game.find(params[:id])
    self.cards = Card.where(game_id: game.id)

    self.dealer_cards = cards.select{|card| card.player == 'dealer'}
    self.dealer_cards_value = Card.get_value_of_cards(dealer_cards)
    self.player_cards = cards.select{|card| card.player == 'you' }
    self.player_cards_value = Card.get_value_of_cards(player_cards)
    self.blackjack_check
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

  def blackjack_check
    self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
    self.dealer_cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
    self.dealer_cards_value = Card.get_value_of_cards(dealer_cards)
    self.player_cards = cards.select{|card| card.player == 'you' }
    self.player_cards_value = Card.get_value_of_cards(player_cards)
    if self.dealer_cards_value == 21 && self.player_cards_value < 21
      self.game.winner = 'dealer'
      self.game.save
    else
      self.dealer_cards.select { |card| card.face_up == true }[0].try(:update, face_up: false)
    end
    if self.player_cards_value == 21 && self.player_cards.length == 2 && self.player_cards_value > self.dealer_cards_value && self.dealer_cards.length == 2
      self.game.winner = 'you'
      self.game.save
    end
    if self.player_cards_value == 21 && self.player_cards.length == 2 && self.dealer_cards_value == 21 && self.dealer_cards.length == 2
      self.game.winner = 'push'
      self.game.save
    end
  end

  def ace_catch
    if self.player_cards_value > 21
      array = self.player_cards.select { |card| card.name == "ace" }
      unless array.empty?
        ace = array[0]
        ace.points = 1
      end
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
    end

    if self.dealer_cards_value > 21
      array = self.dealer_cards.select { |card| card.name == "ace" }
      unless array.empty?
        ace = array[0]
        ace.points = 1
      end
      self.dealer_cards = self.dealer_cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(dealer_cards)
    end
  end

  def chip_diff_double_down
    if self.game.winner == "you"
      current_user.chips += 60
      current_user.save
    end
    if self.game.winner == "dealer"
      current_user.chips -= 60
      current_user.save
    end
  end

  def chip_diff_stand
    if self.game.winner == "you" && self.player_cards_value < 21 || self.player_cards.length > 2
      current_user.chips += 30
      current_user.save
    end
    if self.game.winner == "dealer"
      current_user.chips -= 30
      current_user.save
    end
  end

  def chip_diff_blackjack
    if self.game.winner == "you" && self.player_cards.length == 2 && self.player_cards_value == 21
      current_user.chips += 45
      current_user.save
    end
  end

  def cards_in_deck
    self.cards.select do |card|
      card.player.nil? && !card.discard
    end
  end

  def win(name)
    self.game.update!(:winner => name)
    self.game.save
  end

  def player_rules
    if self.player_cards_value > 21
      self.dealer_cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      win('dealer')
    end
  end

  def dealer_rules
    self.ace_catch
    10.times do
      if self.dealer_cards_value < 17
        Card.run_dealers_hand(self.game, self.cards_in_deck, self.dealer_cards_value, self.player_cards_value)
        self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
        self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      end
    end
    10.times do
      #all the conditions where the winner is you
      if dealer_cards_value > 21 && player_cards_value <= 21
        win 'you'
      end
      if self.dealer_cards_value >= 17 && self.player_cards_value > self.dealer_cards_value && self.player_cards_value <= 21
        win'you'
      end
      #all the conditions where the winner is push
      if self.dealer_cards_value >= 17 && self.player_cards_value == self.dealer_cards_value && self.player_cards_value < 21 && self.dealer_cards_value < 21
        win 'push'
      end
      #all the conditions where the winner is dealer
      if self.dealer_cards_value >= 17 && self.dealer_cards_value < 21 && self.dealer_cards_value > self.player_cards_value
        win 'dealer'
      end
      if self.dealer_cards_value >= 17 && self.player_cards_value < self.dealer_cards_value && self.dealer_cards_value <=21
        win 'dealer'
      end
    end
  end

  def hit
    if params[:commit] == "Hit"
      self.blackjack_check
      if self.player_cards_value < 21
        Card.give_player_a_card(self.cards_in_deck)
      end
      self.cards = Card.where(game_id: self.game.id)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.ace_catch
      self.player_rules
      self.chip_diff_stand
    end
  end

  def stand
    if params[:commit] == "Stand"
      self.blackjack_check
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.ace_catch
      self.player_rules
      self.dealer_rules
      self.chip_diff_blackjack
      self.chip_diff_stand
    end
  end

  def doubledown
    if params[:commit] == "Double Down"
      self.blackjack_check
      Card.give_player_a_card(self.cards_in_deck)
      self.cards.select { |card| card.face_up == false }[0].try(:update, face_up: true)
      self.player_cards = self.cards.select{|card| card.player == 'you'}
      self.player_cards_value = Card.get_value_of_cards(player_cards)
      self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
      self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
      self.ace_catch
      self.player_rules
      self.dealer_rules
      self.chip_diff_double_down
    end
  end

  def setup_new_game
    GameGenerator.generate_cards(params[:id])
    self.game = Game.find(params[:id])
    self.cards = game.cards
    Card.get_four_random_cards(cards_in_deck, current_user.id)
    self.player_cards = self.cards.select{|card| card.player == 'you'}
    self.player_cards_value = Card.get_value_of_cards(player_cards)
    self.dealer_cards = self.cards.select{|card| card.player == 'dealer'}
    self.dealer_cards_value = Card.get_value_of_cards(self.dealer_cards)
    self.ace_catch
  end

  def new_hand
    self.game = Game.find(params[:id])
    self.cards = game.cards
    self.cards.each do |card|
      card.update!(discard: true) if card.player?
    end
    self.game.winner = nil
    self.game.save
    # winner is nil
    # calculate the percentage of discarded cards vs non
    # if that percentage is greater than 40%, reset the deck
    #   discard = false for all
    #   player = false for all
  end
end
