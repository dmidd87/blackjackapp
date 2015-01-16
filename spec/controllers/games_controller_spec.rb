require 'rails_helper'

describe GamesController do
  describe "#update" do
    
    it "deals cards for a game" do
      user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
      session[:user_id] = user.id
      game = Game.create!(user_id: user.id)

      expect {
        patch :update, id: game.id, commit: "Deal Cards"
      }.to change{Card.all.count}
    end

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

      # alternative result code
      # expect {
      #   patch :update, id: game.id
      # }.to change { game.winner}.from(nil).to(user.id.to_s)
      #
      patch :update, id: game.id
      expect(game.reload.winner).to eq user.id.to_s
    end
  end
end
