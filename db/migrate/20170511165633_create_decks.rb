class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.references :game, :card

      t.timestamps
    end
  end
end
