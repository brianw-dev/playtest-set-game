class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :points, default: 0
      t.datetime :time_end
      t.references :user
      t.integer :cards_shown, default: 12
      t.text :cards, default: [], array: true
      t.text :guess, default: [], array: true

      t.timestamps
    end
  end
end
