class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|

      t.timestamps
      t.string :title,         null: false
      t.text   :content,       null: false
      t.integer :award,        null: false
      t.datetime :last_day,    null: false
      t.datetime :deadline,    null: false
      t.references :company,   foreign_key: true
    end
  end
end
