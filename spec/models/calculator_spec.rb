require 'rails_helper'

describe Calculator do

  describe "#setup game" do
    it 'sets up a new game if the params[:commit] is "Deal Cards"' do
      game = Game.create!
      params = {commit: "Deal Cards", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.cards.length).to eq(52)
    end
  end

  describe "#stand" do
    it 'validates that the stand button doesnt give any cards' do
      game = Game.create!
      cardone = Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      cardtwo = Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')
      cardthree = Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      cardfour = Card.create!(game: game, points:5, suit:'club', name:'five', player:'dealer')
      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.player_cards.length).to eq(2)
    end

    it 'declares player as winner after clicking stand' do
      game = Game.create!

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(game.reload.winner).to eq("you")
    end

    it 'declares dealer as winner after clicking stand' do
      game = Game.create!

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:6, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:8, suit:'club', name:'five', player:'dealer')

      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, {})

      calc.run
      expect(game.reload.winner).to eq("dealer")
    end

    it 'validates that if the user hits 21 it automatically makes them stand' do
      pending
      game = Game.create!

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'nine', player:'you')

      @player_cards_value = Card.get_value_of_cards(@player_cards)

      Card.create!(game: game, points:4, suit:'heart', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      calc = Calculator.new(params, {})

      calc.run
    end
  end

  describe "Hit" do
    it 'validates that the user receives a card' do
      game = Game.create!
      Card.create!(game: game, points:2, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:3, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      deck_cards = Card.create!(game: game, points:8, suit:'club', name:'eight')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.player_cards.length).to eq(3)
    end

    it 'validates that if the user has 21 they cannot hit' do
      game = Game.create!

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'nine', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      deck_cards = Card.create!(game: game, points:8, suit:'club', name:'eight')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.player_cards.length).to eq(2)
    end

    it 'validates that if the user goes over 21 then the game is over and the winner is the dealer' do
      game = Game.create!

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(game.reload.winner).to eq("dealer")
    end

    it 'validates that if the user is under 21 after hitting they can hit again' do
      game = Game.create!

      Card.create!(game: game, points:3, suit:'club', name:'three', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.player_cards.length).to eq(4)
    end
  end

  describe "Double Down" do
    it 'validates that the user receives a card' do
      game = Game.create!

      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      expect(calc.player_cards.length).to eq(3)
    end
  end
end
