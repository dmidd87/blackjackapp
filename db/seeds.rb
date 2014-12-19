# t.integer :points
# t.string :suit
# t.string :name

Card.delete_all
Game.delete_all

game = Game.create!([
    {
     :id => 1
    }
])
Card.create!([
  {
    :game_id => game,
    :points => 2,
    :suit => 'club',
    :name => 'two'
  },
  {
    :game_id => game,
    :points => 2,
    :suit => 'spade',
    :name => 'two'
  },
  {
    :game_id => game,
    :points => 2,
    :suit => 'heart',
    :name => 'two'
  },
  {
    :game_id => game,
    :points => 2,
    :suit => 'diamond',
    :name => 'two'
  },
  {
    :points => 3,
    :suit => 'club',
    :name => 'three'
  },
  {
    :points => 3,
    :suit => 'spade',
    :name => 'three'
  },
  {
    :points => 3,
    :suit => 'heart',
    :name => 'three'
  },
  {
    :points => 3,
    :suit => 'diamond',
    :name => 'three'
  },
  {
    :points => 4,
    :suit => 'club',
    :name => 'four'
  },
  {
    :points => 4,
    :suit => 'spade',
    :name => 'four'
  },
  {
    :points => 4,
    :suit => 'heart',
    :name => 'four'
  },
  {
    :points => 4,
    :suit => 'diamond',
    :name => 'four'
  },
  {
    :points => 5,
    :suit => 'club',
    :name => 'five'
  },
  {
    :points => 5,
    :suit => 'spade',
    :name => 'five'
  },
  {
    :points => 5,
    :suit => 'heart',
    :name => 'five'
  },
  {
    :points => 5,
    :suit => 'diamond',
    :name => 'five'
  },
  {
    :points => 6,
    :suit => 'club',
    :name => 'six'
  },
  {
    :points => 6,
    :suit => 'spade',
    :name => 'six'
  },
  {
    :points => 6,
    :suit => 'heart',
    :name => 'six'
  },
  {
    :points => 6,
    :suit => 'diamond',
    :name => 'six'
  },
  {
    :points => 7,
    :suit => 'club',
    :name => 'seven'
  },
  {
    :points => 7,
    :suit => 'spade',
    :name => 'seven'
  },
  {
    :points => 7,
    :suit => 'heart',
    :name => 'seven'
  },
  {
    :points => 7,
    :suit => 'diamond',
    :name => 'seven'
  },
  {
    :points => 8,
    :suit => 'club',
    :name => 'eight'
  },
  {
    :points => 8,
    :suit => 'spade',
    :name => 'eight'
  },
  {
    :points => 8,
    :suit => 'heart',
    :name => 'eight'
  },
  {
    :points => 8,
    :suit => 'diamond',
    :name => 'eight'
  },
  {
    :points => 9,
    :suit => 'club',
    :name => 'nine'
  },
  {
    :points => 9,
    :suit => 'spade',
    :name => 'nine'
  },
  {
    :points => 9,
    :suit => 'heart',
    :name => 'nine'
  },
  {
    :points => 9,
    :suit => 'diamond',
    :name => 'nine'
  },
  {
    :points => 10,
    :suit => 'club',
    :name => 'ten'
  },
  {
    :points => 10,
    :suit => 'spade',
    :name => 'ten'
  },
  {
    :points => 10,
    :suit => 'heart',
    :name => 'ten'
  },
  {
    :points => 10,
    :suit => 'diamond',
    :name => 'ten'
  },
  {
    :points => 10,
    :suit => 'club',
    :name => 'jack'
  },
  {
    :points => 10,
    :suit => 'spade',
    :name => 'jack'
  },
  {
    :points => 10,
    :suit => 'heart',
    :name => 'jack'
  },
  {
    :points => 10,
    :suit => 'diamond',
    :name => 'jack'
  },
  {
    :points => 10,
    :suit => 'club',
    :name => 'queen'
  },
  {
    :points => 10,
    :suit => 'spade',
    :name => 'queen'
  },
  {
    :points => 10,
    :suit => 'heart',
    :name => 'queen'
  },
  {
    :points => 10,
    :suit => 'diamond',
    :name => 'queen'
  },
  {
    :points => 10,
    :suit => 'club',
    :name => 'king'
  },
  {
    :points => 10,
    :suit => 'spade',
    :name => 'king'
  },
  {
    :points => 10,
    :suit => 'heart',
    :name => 'king'
  },
  {
    :points => 10,
    :suit => 'diamond',
    :name => 'king'
  },
  {
    :points => 11,
    :suit => 'club',
    :name => 'ace'
  },
  {
    :points => 11,
    :suit => 'spade',
    :name => 'ace'
  },
  {
    :points => 11,
    :suit => 'heart',
    :name => 'ace'
  },
  {
    :points => 11,
    :suit => 'diamond',
    :name => 'ace'
  },
])
