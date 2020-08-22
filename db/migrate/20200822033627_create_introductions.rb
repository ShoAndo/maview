class CreateIntroductions < ActiveRecord::Migration[6.0]
  def change
    create_table :introductions do |t|

      t.timestamps
      t.text :pr_text
      t.integer :price_per_hour
      t.references :creator, foreign_key: true
    end
  end
end
