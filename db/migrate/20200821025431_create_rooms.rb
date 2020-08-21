class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|

      t.timestamps
      t.string :name, null: false
      t.references :order, foreign_key: true
      t.references :creator, foreign_key: true
      t.references :company, foreign_key: true
    end
  end
end
