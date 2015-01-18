require 'rails_helper'

describe GamesController do
  describe "#update" do

    #Cards dealt

    it "deals cards for a game" do
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      expect {
        patch :update, id: game.id, commit: "Deal Cards"
      }.to change{Card.all.count}
    end

    #All tests referencing being dealt or receiving 21 points in total for player and dealer

    it "When the user is dealt 21 with the first two cards
    a winner is declared and the game is over" do
      Card.destroy_all
      Game.destroy_all
      User.destroy_all

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 10)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 2)
      Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

      # alternative expected code
      # expect {
      #   patch :update, id: game.id
      # }.to change { game.winner}.from(nil).to(user.id.to_s)
      #
      patch :update, id: game.id
      expect(game.reload.winner).to eq user.id.to_s
    end

    it "When the user is has a hand value 21 after with three or more cards a winner hasn't been
    declared because the dealer still flips over card and receives cards until 21 or bust" do
    pending
      Card.destroy_all
      Game.destroy_all
      User.destroy_all

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 5)
      Card.create!(game_id: game.id, player: "you", points: 5)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 7, face_up: false)

      #Need to add hit action instead of creating a card for the player?

      Card.create!(game_id: game.id, player: "you", points: 11)

      #Expect dealer card 2 to flip face up and the dealer to hit

      expect {
        patch :update, id: game.id
      }.to change { game.winner}.from(nil).to("push")
    end

    it "When the dealer is dealt 21 it instantly ends the hand before the user can do any actions" do
      pending
      Card.destroy_all
      Game.destroy_all
      User.destroy_all

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 5)
      Card.create!(game_id: game.id, player: "you", points: 5)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 11, face_up: false)

      #Add controller function to run a check for face down card to see if
      #dealer card value is equal to 21

      expect {
        patch :update, id: game.id
      }.to change { game.winner}.from(nil).to("dealer")
    end

    #Busted

    it "When the player hits and receives a hand with a greater value than 21
    the dealer is declared the winner" do
    pending
    Card.destroy_all
    Game.destroy_all
    User.destroy_all

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 6)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    #Add hit action not Card.create!

    Card.create!(game_id: game.id, player: "you", points: 6)

    expect {
      patch :update, id: game.id
    }.to change { game.winner}.from(nil).to("dealer")
    end

    #Dealer busts

    it "When the player stands and the dealer hits and the value of the dealers hand
    busts the user is declared the winner" do
    pending
    Card.destroy_all
    Game.destroy_all
    User.destroy_all

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 6)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    #Player stands

    Card.create!(game_id: game.id, player: "dealer", points: 10)

    expect {
      patch :update, id: game.id
    }.to change { game.winner}.from(nil).to("you")
    end

    it "Player hits once then stands and dealer busts" do
    pending

    Card.destroy_all
    Game.destroy_all
    User.destroy_all

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 1)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    #Player hits

    Card.create!(game_id: game.id, player: "you", points: 7)

    #Player stays

    #Dealer action runs?

    expect {
      patch :update, id: game.id
    }.to change { game.winner}.from(nil).to("you")
    end

    it "Player hits twice then stands and dealer busts" do
      pending

      Card.destroy_all
      Game.destroy_all
      User.destroy_all

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 2)
      Card.create!(game_id: game.id, player: "you", points: 1)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

      #Player hits
      #Player hits

      Card.create!(game_id: game.id, player: "you", points: 7)
      Card.create!(game_id: game.id, player: "you", points: 10)

      #Player stays

      #Dealer action runs?

      Card.create!(game_id: game.id, player: "dealer", points: 8)

      expect {
        patch :update, id: game.id
      }.to change { game.winner}.from(nil).to("you")
    end

    it "Player hits three times then stands and dealer busts" do
      pending

      Card.destroy_all
      Game.destroy_all
      User.destroy_all

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 2)
      Card.create!(game_id: game.id, player: "you", points: 4)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

      #Player hits
      #Player hits

      Card.create!(game_id: game.id, player: "you", points: 2)
      Card.create!(game_id: game.id, player: "you", points: 2)
      Card.create!(game_id: game.id, player: "you", points: 10)

      #Player stays
      #Dealer action runs?

      Card.create!(game_id: game.id, player: "dealer", points: 11)

      expect {
        patch :update, id: game.id
      }.to change { game.winner}.from(nil).to("you")
    end

    #DOUBLE DOWN BUTTON TESTS

    it "Player hits double down, is dealt one card, hits 21, dealer runs their hand and loses"
    pending
    end

    it "Player hits double down, busts, and the dealer reveals their face down card and wins"
    pending
    end

    it "Player hits double down, has a lower score than the dealer, the dealer flips over their
    face down card and is declared the winner"
    pending
    end
  end
end
