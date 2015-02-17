class Discard < ActiveRecord::Migration
  def change
    add_column :cards, :discard, :boolean, default: false
  end
end
