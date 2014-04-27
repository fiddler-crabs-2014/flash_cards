class CreateGuessesTable < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.belongs_to :round
      t.boolean  :correct, default: false
      t.string :correct_answer

      t.timestamps
    end
  end
end
