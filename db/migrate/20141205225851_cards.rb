class Cards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :points
      t.string :suit
      t.string :name
    end
  end
end
