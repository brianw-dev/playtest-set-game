class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.integer :points
      t.datetime :time_end
      t.references :user

      t.timestamps
    end
  end
end
