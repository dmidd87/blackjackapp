require 'rails_helper'

describe "Stand" do
  it 'validates that the stand button doesnt give any cards' do
    user = User.create!(first_name: "David", last_name: "Example", email_address: "david@example.com", password: "password")
    user.valid?
    game = Game.create!(user_id: user.id)
    game.valid?
    Card.create!(game_id: game.id, player: "you", points: 8)
    Card.create!(game_id: game.id, player: "you", points: 11)
    Card.create!(game_id: game.id, player: "dealer", points: 10)
    Card.create!(game_id: game.id, player: "dealer", points: 7, face_up: false)
  end


  it 'validates when it runs the dealers hand that if the dealer busts the player wins' do

  end

  it 'validates that when the dealer has less than 21 but a greater value than the player
  the dealer wins' do

  end

  it 'validates that the user cannot click any other buttons after standing' do

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

  end

  it 'validates that the user can stand after hitting' do

  end

  it 'validates that if the player hits and receives an ace and goes over 21 the value of
  the ace goes to 1' do

  end
end

describe "Double Down" do
  it 'validates that when double down is clicked that the player receives a card' do

  end

  it 'validates that after the card is received you cant click any other buttons' do

  end

  it 'validates that if the user goes over 21 the dealer is the winner' do

  end
end
