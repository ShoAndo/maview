class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|

      t.timestamps
      t.string :card_token,     null: false
      t.string :customer_token, null: false
      t.references :company,    foreign_key: true
    end
  end
end
