class Hands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.belongs_to :user
    end
  end
end
