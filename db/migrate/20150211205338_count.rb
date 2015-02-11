class Count < ActiveRecord::Migration
  def change
    add_column :cards, :count_value, :integer
  end
end
