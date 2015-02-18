require 'rails_helper'

describe Calculator do

  describe "#setup game" do
    it 'sets up a new game if "Deal Cards" is clicked' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      params = {commit: "Deal Cards", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.cards_in_deck.length).to eq(100)
    end

    it 'checks if a dealer is dealt natural blackjack and ends the hand if the dealer is dealt natural blackjack and the player doesnt have blackjack' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'diamond', name:'ace', player:'you')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')
      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:11, suit:'club', name:'eleven', player:'dealer')

      params = {id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.game.winner).to eq("dealer")
    end

    it 'checks if a dealer is dealt natural blackjack and ends the hand with a push if the dealer is dealt natural blackjack and the player has natural blackjack' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'diamond', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'you')
      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'dealer')

      params = {id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.game.winner).to eq("push")
    end

    it 'checks if a player is dealt natural blackjack, dealer loses because dealer has a hand value under 21 'do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'diamond', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'you')
      Card.create!(game: game, points:6, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'dealer')

      params = {id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.game.winner).to eq("you")
    end
  end

  describe "#chips" do
    it 'verifies that when a player wins their chips increase' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:5, suit:'club', name:'five', player:'dealer')

      Card.create!(game: game, points:3, suit:'diamond', name:'three')

      params = {commit: "Stand", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(current_user.chips).to eq(1030)
    end

    it 'verifies that when a player loses they lose chips' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'you')
      Card.create!(game: game, points:5, suit:'club', name:'five', player:'you')

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'dealer')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'dealer')

      Card.create!(game: game, points:3, suit:'diamond', name:'three')

      params = {commit: "Stand", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(current_user.chips).to eq(970)
    end

    it 'verifies that when a player wins on a double down they win double the initial bet' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:5, suit:'club', name:'five', player:'you')
      Card.create!(game: game, points:5, suit:'diamond', name:'five', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:11, suit:'diamond', name:'ace')

      params = {commit: "Double Down", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(current_user.chips).to eq(1060)
    end

    it 'verifies that when a player wins with blackjack they win 1.5x their bet' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'you')
      Card.create!(game: game, points:11, suit:'diamond', name:'ace', player:'you')

      Card.create!(game: game, points:10, suit:'diamond', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:11, suit:'spade', name:'ace')

      params = {commit: "Stand", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(current_user.chips).to eq(1045)
    end

    it 'verifies that when a player loses on a double down they lose double the initial bet' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:5, suit:'club', name:'five', player:'you')
      Card.create!(game: game, points:5, suit:'diamond', name:'five', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:2, suit:'diamond', name:'two')

      params = {commit: "Double Down", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(current_user.chips).to eq(940)
    end
  end

  describe "#stand" do
    it 'validates that the stand button doesnt give any cards' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:5, suit:'club', name:'five', player:'dealer')

      Card.create!(game: game, points:4, suit:'diamond', name:'four')

      params = {commit: "Stand", id: game.id}

      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(2)
    end

    it 'declares player as winner after clicking stand' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(game.reload.winner).to eq("you")
    end

    it 'declares dealer as winner after clicking stand' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:6, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:8, suit:'club', name:'five', player:'dealer')

      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run
      expect(game.reload.winner).to eq("dealer")
    end

    it 'validates that if the user receives a hand value of 21 it will run the dealers hand if you click stand' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'spades', name:'ten', player:'you')

      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'dealer')
      Card.create!(game: game, points:8, suit:'club', name:'eight', player:'dealer')

      Card.create!(game: game, points:9, suit:'diamond', name:'nine')

      params = {commit: "Stand", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(game.reload.winner).to eq("you")
    end
  end

  describe "Hit" do
    it 'validates that if the user has 21 they cannot hit' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'nine', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      Card.create!(game: game, points:8, suit:'club', name:'eight')
      Card.create!(game: game, points:8, suit:'diamond', name:'eight')
      Card.create!(game: game, points:10, suit:'diamond', name:'ten')


      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(2)
    end

    it 'validates that the user receives a card' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:2, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:3, suit:'club', name:'nine', player:'you')

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'five', player:'dealer')

      Card.create!(game: game, points:8, suit:'club', name:'eight')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(3)
    end

    it 'validates that if the user hits and goes over 21 then the game is over and the winner is the dealer' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:10, suit:'club', name:'ten', player:'you')
      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:8, suit:'club', name:'eight')
      Card.create!(game: game, points:10, suit:'diamond', name:'ten')


      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(game.reload.winner).to eq("dealer")
    end

    # if you need to control randomness
    # call srand(0) in a before
    # and then reset it in an after (optional)
    # OR
    # expect(Card).to receive(:give_player_a_card).and_return(...)

    it 'validates that if the user is under 21 after hitting they can hit again' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:3, suit:'club', name:'three', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:8, suit:'club', name:'eight')
      Card.create!(game: game, points:9, suit:'club', name:'nine')
      Card.create!(game: game, points:10, suit:'diamond', name:'ten')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(4)
    end

    it 'validates that if the user is over 21 after hitting and they have an ace, that aces value defaults to 1' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:11, suit:'club', name:'ace', player:'you')
      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'you')

      Card.create!(game: game, points:10, suit:'heart', name:'four', player:'dealer')
      Card.create!(game: game, points:9, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:11, suit:'club', name:'ace')

      params = {commit: "Hit", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(3)
      expect(calc.player_cards_value).to eq(16)
      expect(calc.game.winner).to eq(nil)
    end
  end

  describe "Double Down" do
    it 'validates that the user receives a card and wins' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:9, suit:'club', name:'nine', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:10, suit:'heart', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:8, suit:'club', name:'eight')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq('you')
    end

    it 'validates that if the dealer has 17 and the player doubles down and gets 18 player wins' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:2, suit:'spade', name:'five', player:'you')
      Card.create!(game: game, points:6, suit:'heart', name:'six', player:'you')

      Card.create!(game: game, points:10, suit:'diamond', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:10, suit:'spade', name:'ten')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.dealer_cards.length).to eq(2)
      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq("you")
    end

    it 'validates that if the dealer has 17 and the player doubles down and gets 16 dealer wins' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:2, suit:'spade', name:'five', player:'you')
      Card.create!(game: game, points:4, suit:'heart', name:'four', player:'you')

      Card.create!(game: game, points:10, suit:'diamond', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'seven', player:'dealer')

      Card.create!(game: game, points:10, suit:'spade', name:'ten')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.dealer_cards.length).to eq(2)
      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq("dealer")
    end

    it 'validates that if the dealer has 17 and the player doubles down and gets 17 it is a push' do
      game = Game.create!

      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:2, suit:'spade', name:'two', player:'you')
      Card.create!(game: game, points:5, suit:'heart', name:'five', player:'you')

      Card.create!(game: game, points:10, suit:'diamond', name:'ten', player:'dealer')
      Card.create!(game: game, points:7, suit:'club', name:'six', player:'dealer')

      Card.create!(game: game, points:10, suit:'spade', name:'ten')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.dealer_cards.length).to eq(2)
      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq("push")
    end

    it 'validates that if the player doubles down they receive a card and the dealer runs their hand receiving one card and losing' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:9, suit:'spade', name:'nine', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:10, suit:'diamond', name:'ten', player:'dealer')
      Card.create!(game: game, points:6, suit:'club', name:'six', player:'dealer')

      Card.create!(game: game, points:10, suit:'heart', name:'ten')
      Card.create!(game: game, points:10, suit:'spade', name:'six')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.dealer_cards.length).to eq(3)
      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq("you")
    end

    it 'validates that if the player doubles down they receive a card and the dealer runs their hand receiving one card and winning' do
      game = Game.create!
      current_user = User.create!(
      first_name: "Test",
      last_name: "User",
      email_address: "test@test.com",
      password: "password",
      chips: 1000)

      Card.create!(game: game, points:2, suit:'spade', name:'two', player:'you')
      Card.create!(game: game, points:2, suit:'heart', name:'two', player:'you')

      Card.create!(game: game, points:3, suit:'diamond', name:'three', player:'dealer')
      Card.create!(game: game, points:6, suit:'club', name:'six', player:'dealer')

      Card.create!(game: game, points:10, suit:'heart', name:'ten')
      Card.create!(game: game, points:10, suit:'spade', name:'six')

      params = {commit: "Double Down", id: game.id}
      calc = Calculator.new(params, current_user)

      calc.run

      expect(calc.dealer_cards.length).to eq(3)
      expect(calc.player_cards.length).to eq(3)
      expect(game.reload.winner).to eq("dealer")
    end
  end
end
