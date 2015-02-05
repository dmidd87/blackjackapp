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
      params = {commit: "Deal Cards", id: game.id}
      cardone = Card.create!(points:11, suit:'club', name:'ace', player:'you')
      cardtwo = Card.create!(points:9, suit:'club', name:'nine', player:'you')
      cardthree = Card.create!(points:10, suit:'club', name:'ten', player:'dealer')
      cardfour = Card.create!(points:5, suit:'club', name:'five', player:'dealer')
      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, {})

      calc.run

      cardfive = Card.create!(points:10, suit:'heart', name:'ten', player:'dealer')

      expect(calc.player_cards.length).to eq(2)
    end

    it 'validates when it runs the dealers hand that if the dealer busts the player wins' do
      pending
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      user.valid?
      game = Game.create!(user_id: user.id)
      game.valid?

      Card.create!(game_id: game.id, player: "you", points: 8)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 4)
      Card.create!(game_id: game.id, player: "dealer", points: 10, face_up: false)

      [:commit] == "Stand"

      Card.create!(game_id: game.id, player: "dealer", points: 8)

      expect(game.reload.winner).to eq("you")
    end

    it 'validates that when the dealer has less than 21 but a greater value than the player the dealer wins' do
      pending
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      user.valid?
      game = Game.create!(user_id: user.id)
      game.valid?

      Card.create!(game_id: game.id, player: "you", points: 8)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 10, face_up: false)

      [:commit] == "Stand"

      expect(game.reload.winner).to eq("dealer")
    end

    it 'validates that the user cannot click any other buttons after standing' do
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      user.valid?
      game = Game.create!(user_id: user.id)
      game.valid?

      Card.create!(game_id: game.id, player: "you", points: 8)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 9)
      Card.create!(game_id: game.id, player: "dealer", points: 10, face_up: false)

      [:commit] == "Stand"
    end
  end


  describe "Hit" do
    it 'validates that the user receives a card' do

    end

    it 'validates that if the user goes over 21 then the game is over and the winner is the dealer' do

    end

    it 'validates that if the user hits 21 it automatically makes them stand' do

    end

    it 'validates that if the users hand value is below 21 they can hit again' do

    end

    it 'validates that the user cannot double down or split after hitting' do
      pending
    end

    it 'validates that the user can stand after hitting' do
      pending
    end

    it 'validates that if the player hits and receives an ace and goes over 21 the value of the ace goes to 1' do
      pending
    end

  end

  describe "Double Down" do
    it 'validates that when double down is clicked that the player receives a card' do
      pending
    end

    it 'validates that after the card is received you cant click any other buttons' do
      pending
    end

    it 'validates that if the user goes over 21 the dealer is the winner' do
      pending
    end
  end

end
