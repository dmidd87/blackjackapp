class Deckcards < ActiveRecord::Migration
  def change
    create_table :deckcards do |t|
      t.belongs_to :card_id
      t.belongs_to :game_id
      t.string :player
      t.string :dealer
    end
  end
end
