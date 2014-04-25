class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :deck
      t.belongs_to :user
      t.integer  :score, default: 0

      t.timestamps
    end
  end
end
