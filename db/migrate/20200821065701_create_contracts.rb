class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|

      t.timestamps
      t.references :order, foreign_key: true
      t.references :creator, foreign_key: true
      t.references :company, foreign_key: true
    end
  end
end
