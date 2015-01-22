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

    it "When the dealer has natural blackjack and the player doesn't
    the dealer wins and the player loses" do
    pending
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 3)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 11, face_up: false)

      #how do i check the facedown card

      patch :update, id: game.id
      expect(game.reload.winner).to eq("dealer")
    end

    it "When the user is dealt blackjack within the first two cards, the dealer runs their hand and busts
    and the user wins" do

      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 10)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 10)
      Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

      Card.create!(game_id: game.id, player: nil, points: 10)

      patch :update, id: game.id
      expect(game.reload.winner).to eq("you")
    end

    it "When the user has blackjack and the dealer has blackjack it results in a push" do
      pending
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 10)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 11)
      Card.create!(game_id: game.id, player: "dealer", points: 10, face_up: false)

      #how do i chk facedown card

      expect {
        patch :update, id: game.id
      }.to change { game.reload.winner }.from(nil).to("push")
    end

    it "When the user has blackjack and the dealer hits and receives blackjack it results in a push" do
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      Card.create!(game_id: game.id, player: "you", points: 10)
      Card.create!(game_id: game.id, player: "you", points: 11)

      Card.create!(game_id: game.id, player: "dealer", points: 11)
      Card.create!(game_id: game.id, player: "dealer", points: 5, face_up: false)

      #Card not being flipped up?

      Card.create!(game_id: game.id, player: "dealer", points: 5)

      expect {
        patch :update, id: game.id
      }.to change { game.reload.winner }.from(nil).to("push")
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

      #chk facedown card

      expect {
        patch :update, id: game.id
      }.to change { game.winner}.from(nil).to("dealer")
    end

    #Busted

    it "When the player hits and receives a hand with a greater value than 21
    the dealer is declared the winner" do

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 6)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    Card.create!(game_id: game.id, player: "you", points: 6)

    patch :update, id: game.id
    expect(game.reload.winner).to eq("dealer")
    end

    it "When the player stands and the dealer hits and the value of the dealers hand
    busts the user is declared the winner" do

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 7)

    Card.create!(game_id: game.id, player: "dealer", points: 3)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 10)

    patch :update, id: game.id
    expect(game.reload.winner).to eq("you")
    end

    it "Player hits once then stands and dealer busts" do

    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    session[:user_id] = user.id
    game = Game.create!(user_id: user.id)

    Card.create!(game_id: game.id, player: "you", points: 10)
    Card.create!(game_id: game.id, player: "you", points: 3)

    Card.create!(game_id: game.id, player: "dealer", points: 6)
    Card.create!(game_id: game.id, player: "dealer", points: 2, face_up: false)

    Card.create!(game_id: game.id, player: "you", points: 7)

    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 6)

    patch :update, id: game.id
    expect(game.reload.winner).to eq("you")
    end
  end
end
