class GamesController < ApplicationController

  def index
  end

  def show
    @user = current_user
    @hand = Hand.new(user_id: @user.id)
    @game = Game.find(params[:id])
    @cards = Card.where(game_id: @game.id)
    @player_cards, @dealer_cards = Card.get_four_random_cards(@cards, session[:user_id])
    if @cards = nil?
      @redraw_button = true
    else
      @player_cards_value = Card.get_value_of_cards(@player_cards)
      @dealer_cards_value = Card.get_value_of_cards(@dealer_cards)
    end
  end

  def create
    @game = Game.new({:created_at => Time.now})
    @game.save
    GameGenerator.generate_cards(@game.id)
    redirect_to game_path(@game)
  end

  def update
  end
end
