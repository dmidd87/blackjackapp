class GamesController < ApplicationController

  def index
  end

  def show
    @user = current_user
    @hand = Hand.new(user_id: @user.id)
    @game = Game.find(params[:id])
    @cards = Card.where(game_id: @game.id)
    @player_cards = @cards.select{|card| card.player == 'you' }
    @dealer_cards = @cards.select{|card| card.player == 'dealer' }
    @player_cards_value = Card.get_value_of_cards(@player_cards)
    @dealer_cards_value = Card.get_value_of_cards(@dealer_cards)
  end

  def create
    game = Game.new({:created_at => Time.now})
    game.save
    redirect_to game_path(game)
  end

  def update
    result = Calculator.calculate(params, current_user)
    @game = result[:game]
    @dealer_cards_value = result[:dealer_cards_value]
    @player_cards_value = result[:player_cards_value]
    @cards = result[:cards]
    redirect_to game_path(@game)
  end
end
