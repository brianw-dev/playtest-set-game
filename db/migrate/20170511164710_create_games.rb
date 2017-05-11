class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :points
      t.datetime :time_end
      t.references :user
      t.text :cards, :guess, array: true

      t.timestamps
    end
  end
end
