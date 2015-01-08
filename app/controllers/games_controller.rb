class GamesController < ApplicationController

  def index
  end

  def show
    @game = Game.find(params[:id])
    @cards = Card.where(game_id: @game.id)
    @cards_in_play = Card.get_four_random_cards(@cards)
    if @cards_in_play == []
      @cards_in_play = []
    end
  end

  # CRUD users, pass in user id to cards in play
  # Make sure users are assigned two cards after users is CRUD
  # fix error message when deck runs out in games show view
  # deal 2 cards to the user instead of four to seperate dealer from user

  def create
    @game = Game.new({:created_at => Time.now})
    @game.save
    GameGenerator.generate_cards(@game.id)
    redirect_to game_path(@game)
    # deal will take 4 cards from deck(seeded database)
    # eliminate card id's of the cards that have been delt from the database
  end

  def update

  end
  # def NewShoe
  #   @completedeck.rand(4).times do |card| #each do?
  #   #call on four random cards from the @completedeck
  # end
end
