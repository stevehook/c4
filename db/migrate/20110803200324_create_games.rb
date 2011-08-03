class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :status
      t.text :grid
      t.text :moves

      t.timestamps
    end
  end
end
