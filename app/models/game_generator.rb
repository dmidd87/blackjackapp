class GameGenerator

  def self.generate_cards(game_id)
    Card.create!([
      {
        :game_id => game_id,
        :points => 2,
        :suit => 'club',
        :name => 'two',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 2,
        :suit => 'spade',
        :name => 'two',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 2,
        :suit => 'heart',
        :name => 'two',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 2,
        :suit => 'diamond',
        :name => 'two',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 3,
        :suit => 'club',
        :name => 'three',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 3,
        :suit => 'spade',
        :name => 'three',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 3,
        :suit => 'heart',
        :name => 'three',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 3,
        :suit => 'diamond',
        :name => 'three',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 4,
        :suit => 'club',
        :name => 'four',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 4,
        :suit => 'spade',
        :name => 'four',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 4,
        :suit => 'heart',
        :name => 'four',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 4,
        :suit => 'diamond',
        :name => 'four',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 5,
        :suit => 'club',
        :name => 'five',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 5,
        :suit => 'spade',
        :name => 'five',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 5,
        :suit => 'heart',
        :name => 'five',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 5,
        :suit => 'diamond',
        :name => 'five',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 6,
        :suit => 'club',
        :name => 'six',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 6,
        :suit => 'spade',
        :name => 'six',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 6,
        :suit => 'heart',
        :name => 'six',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 6,
        :suit => 'diamond',
        :name => 'six',
        :count_value => 1
      },
      {
        :game_id => game_id,
        :points => 7,
        :suit => 'club',
        :name => 'seven',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 7,
        :suit => 'spade',
        :name => 'seven',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 7,
        :suit => 'heart',
        :name => 'seven',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 7,
        :suit => 'diamond',
        :name => 'seven',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 8,
        :suit => 'club',
        :name => 'eight',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 8,
        :suit => 'spade',
        :name => 'eight',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 8,
        :suit => 'heart',
        :name => 'eight',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 8,
        :suit => 'diamond',
        :name => 'eight',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 9,
        :suit => 'club',
        :name => 'nine',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 9,
        :suit => 'spade',
        :name => 'nine',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 9,
        :suit => 'heart',
        :name => 'nine',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 9,
        :suit => 'diamond',
        :name => 'nine',
        :count_value => 0
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'club',
        :name => 'ten',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'spade',
        :name => 'ten',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'heart',
        :name => 'ten',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'diamond',
        :name => 'ten',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'club',
        :name => 'jack',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'spade',
        :name => 'jack',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'heart',
        :name => 'jack',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'diamond',
        :name => 'jack',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'club',
        :name => 'queen',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'spade',
        :name => 'queen',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'heart',
        :name => 'queen',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'diamond',
        :name => 'queen',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'club',
        :name => 'king',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'spade',
        :name => 'king',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'heart',
        :name => 'king',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 10,
        :suit => 'diamond',
        :name => 'king',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 11,
        :suit => 'club',
        :name => 'ace',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 11,
        :suit => 'spade',
        :name => 'ace',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 11,
        :suit => 'heart',
        :name => 'ace',
        :count_value => -1
      },
      {
        :game_id => game_id,
        :points => 11,
        :suit => 'diamond',
        :name => 'ace',
        :count_value => -1
      }
    ])
  end
end
