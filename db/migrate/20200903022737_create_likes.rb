class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|

      t.timestamps
      t.references :order, foreign_key: true
      t.references :creator, foreign_key: true
    end
  end
end
