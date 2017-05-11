class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string   :image
      t.string   :color
      t.string   :symbol
      t.string   :number
      t.string   :shading

      t.timestamps
    end
  end
end
