class CreatePortforios < ActiveRecord::Migration[6.0]
  def change
    create_table :portforios do |t|

      t.timestamps
      t.text :outline
      t.string :url
      t.text :detail
      t.string :github
      t.references :creator, foreign_key: true
    end
  end
end
