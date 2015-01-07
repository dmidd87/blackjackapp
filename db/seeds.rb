Card.delete_all
Game.delete_all

game = Game.create!

if game.present?
  p "GAME CREATED"
end

Card.create!([
  {
    :game_id => game.id,
    :points => 2,
    :suit => 'club',
    :name => 'two'
  },
  {
    :game_id => game.id,
    :points => 2,
    :suit => 'spade',
    :name => 'two'
  },
  {
    :game_id => game.id,
    :points => 2,
    :suit => 'heart',
    :name => 'two'
  },
  {
    :game_id => game.id,
    :points => 2,
    :suit => 'diamond',
    :name => 'two'
  },
  {
    :game_id => game.id,
    :points => 3,
    :suit => 'club',
    :name => 'three'
  },
  {
    :game_id => game.id,
    :points => 3,
    :suit => 'spade',
    :name => 'three'
  },
  {
    :game_id => game.id,
    :points => 3,
    :suit => 'heart',
    :name => 'three'
  },
  {
    :game_id => game.id,
    :points => 3,
    :suit => 'diamond',
    :name => 'three'
  },
  {
    :game_id => game.id,
    :points => 4,
    :suit => 'club',
    :name => 'four'
  },
  {
    :game_id => game.id,
    :points => 4,
    :suit => 'spade',
    :name => 'four'
  },
  {
    :game_id => game.id,
    :points => 4,
    :suit => 'heart',
    :name => 'four'
  },
  {
    :game_id => game.id,
    :points => 4,
    :suit => 'diamond',
    :name => 'four'
  },
  {
    :game_id => game.id,
    :points => 5,
    :suit => 'club',
    :name => 'five'
  },
  {
    :game_id => game.id,
    :points => 5,
    :suit => 'spade',
    :name => 'five'
  },
  {
    :game_id => game.id,
    :points => 5,
    :suit => 'heart',
    :name => 'five'
  },
  {
    :game_id => game.id,
    :points => 5,
    :suit => 'diamond',
    :name => 'five'
  },
  {
    :game_id => game.id,
    :points => 6,
    :suit => 'club',
    :name => 'six'
  },
  {
    :game_id => game.id,
    :points => 6,
    :suit => 'spade',
    :name => 'six'
  },
  {
    :game_id => game.id,
    :points => 6,
    :suit => 'heart',
    :name => 'six'
  },
  {
    :game_id => game.id,
    :points => 6,
    :suit => 'diamond',
    :name => 'six'
  },
  {
    :game_id => game.id,
    :points => 7,
    :suit => 'club',
    :name => 'seven'
  },
  {
    :game_id => game.id,
    :points => 7,
    :suit => 'spade',
    :name => 'seven'
  },
  {
    :game_id => game.id,
    :points => 7,
    :suit => 'heart',
    :name => 'seven'
  },
  {
    :game_id => game.id,
    :points => 7,
    :suit => 'diamond',
    :name => 'seven'
  },
  {
    :game_id => game.id,
    :points => 8,
    :suit => 'club',
    :name => 'eight'
  },
  {
    :game_id => game.id,
    :points => 8,
    :suit => 'spade',
    :name => 'eight'
  },
  {
    :game_id => game.id,
    :points => 8,
    :suit => 'heart',
    :name => 'eight'
  },
  {
    :game_id => game.id,
    :points => 8,
    :suit => 'diamond',
    :name => 'eight'
  },
  {
    :game_id => game.id,
    :points => 9,
    :suit => 'club',
    :name => 'nine'
  },
  {
    :game_id => game.id,
    :points => 9,
    :suit => 'spade',
    :name => 'nine'
  },
  {
    :game_id => game.id,
    :points => 9,
    :suit => 'heart',
    :name => 'nine'
  },
  {
    :game_id => game.id,
    :points => 9,
    :suit => 'diamond',
    :name => 'nine'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'club',
    :name => 'ten'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'spade',
    :name => 'ten'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'heart',
    :name => 'ten'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'diamond',
    :name => 'ten'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'club',
    :name => 'jack'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'spade',
    :name => 'jack'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'heart',
    :name => 'jack'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'diamond',
    :name => 'jack'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'club',
    :name => 'queen'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'spade',
    :name => 'queen'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'heart',
    :name => 'queen'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'diamond',
    :name => 'queen'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'club',
    :name => 'king'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'spade',
    :name => 'king'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'heart',
    :name => 'king'
  },
  {
    :game_id => game.id,
    :points => 10,
    :suit => 'diamond',
    :name => 'king'
  },
  {
    :game_id => game.id,
    :points => 11,
    :suit => 'club',
    :name => 'ace'
  },
  {
    :game_id => game.id,
    :points => 11,
    :suit => 'spade',
    :name => 'ace'
  },
  {
    :game_id => game.id,
    :points => 11,
    :suit => 'heart',
    :name => 'ace'
  },
  {
    :game_id => game.id,
    :points => 11,
    :suit => 'diamond',
    :name => 'ace'
  },
])
