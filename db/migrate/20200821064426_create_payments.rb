class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|

      t.timestamps
      t.integer :price, null: false
    end
  end
end
