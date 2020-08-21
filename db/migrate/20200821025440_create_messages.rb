class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|

      t.timestamps
      t.string  :content
      t.references :room, foreign_key: true
      t.string :category, null: false
    end
  end
end
