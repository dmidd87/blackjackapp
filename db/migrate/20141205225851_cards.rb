class Cards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :points
      t.string :suit
      t.string :name
      t.belongs_to :game
      t.string :player
      t.boolean :face_up, default: true, null: false
    end
  end
end
